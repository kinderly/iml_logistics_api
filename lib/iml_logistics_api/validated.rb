require_relative 'exceptions'
require 'date'
module ImlLogisticsApi
  module Validated
    attr_reader :errors

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def xml_options(options = {})
        @xml_options = options
        @xml_options[:tag] ||= self.name
      end

      def get_xml_options
        @xml_options
      end

      def field(*args)
        options = extract_options(args)
        @fields ||= {}

        options[:validator] = get_validator(options[:pattern])
        args.each do |field|
          @fields[field] = options
          attr_accessor field
        end
      end

      def fields
        @fields
      end

      def get_validator(pattern)
        parsed = parse_pattern(pattern)
        return lambda{|v| true} if parsed.nil?
        symbols, strict, quantity, precision = parsed

        char_patterns = []
        char_patterns << '\p{L}' if symbols.include?('a')
        char_patterns << '\d' if symbols.include?('n')

        quantity_pattern = if quantity
          if strict
            "{#{quantity}}"
          else
            "{,#{quantity}}"
          end
        else
          '*'
        end

        match_regex = Regexp.new("^[#{char_patterns.join}]#{quantity_pattern}$")

        if symbols.include?('a')
          return lambda {|v| !v.to_s.match(match_regex).nil?}
        else
          if precision
            max_decimal = 10 ** precision
            return lambda{|v| (v.is_a? Numeric) && ( (v * max_decimal) % 1 == 0) }
          else
            if quantity
              max = 10 ** quantity.to_i
              min = 10 ** (quantity.to_i - 1) if strict
              return lambda{|v|
                if v.is_a? String
                  !v.match(match_regex).nil?
                elsif v.is_a? Integer
                  v < max && (min.nil? || min <= v)
                else
                  !v.to_s.match(match_regex).nil?
                end
              }
            else
              return lambda { |v|
                if v.is_a? String
                  !v.match(match_regex).nil?
                elsif v.is_a? Integer
                  true
                else
                  !v.to_s.match(match_regex).nil?
                end
              }
            end
          end
        end
      end

      def parse_pattern(pattern)
        return nil if pattern.nil?

        regex = /^(a|n|an)((\.\.)?(\d+)(,(\d+))?)?$/
        match = pattern.match(regex)
        raise ImlLogisticsApi::Exceptions::Error, 'Invalid validation pattern' if match.nil?

        symbols = match[1]
        strict = match[3].nil?
        quantity = match[4] ? match[4].to_i : nil
        precision = match[6] ? match[6].to_i : nil

        [symbols, strict, quantity, precision]
      end

      def extract_options(args)
        if args.last.is_a?(Hash) && args.last.instance_of?(Hash)
          args.pop
        else
          {}
        end
      end

    end # ClassMethods

    def valid?
      @errors = []

      self.class.fields.each do |field, options|
        value = self.send(field)
        validate_field(field, value, options)
      end

      errors.empty?
    end

    def to_xml(xml_builder = nil, &block)
      if xml_builder.nil?
        Nokogiri::XML::Builder.new do |xml|
          to_xml_internal(xml, &block)
        end.to_xml
      else
        to_xml_internal(xml_builder, &block)
      end
    end

    protected

    def to_xml_internal(xml_builder)
      options = self.class.get_xml_options
      fields = self.class.fields
      xml_builder.send(options[:tag]) do
        fields.each do |f, f_options|
          value = self.send(f)
          next if value.nil?

          if f_options[:type]
            if f_options[:array]
              if f_options[:tag]
                xml_builder.send(f_options[:tag]) do
                  value.each do |item|
                    item.to_xml(xml_builder)
                  end
                end
              else
                value.each do |item|
                  item.to_xml(xml_builder)
                end
              end
            else
              value.to_xml(xml_builder)
            end
          else
            xml_builder.send(f_options[:tag] || f) do
              xml_builder.text(format_field(f, value, f_options))
            end
          end

        end
        yield xml_builder if block_given?
      end
    end

    def format_field(field, value, options)
      if value.is_a?(DateTime)
        value.strftime('%Y-%m-%dT%H:%M:%S')
      elsif value.is_a?(Date)
        value.strftime('%Y-%m-%d')
      else
        value.to_s
      end
    end

    def validate_field(field, value, options)
      if options[:use] == 'R'&& value.nil?
        add_error(field, value, "Field '#{field}' is required.")
      end

      if !options[:validator].call(format_field(field, value, options))
        add_error(field, value, "Invalid value '#{value}' for field '#{field}'.")
      end
    end

    def add_error(field, value, message)
      @errors << {
        field: field,
        value: value,
        message: message
      }
    end
  end # Validated
end # ImlLogisticsApi
