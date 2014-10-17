require 'nokogiri'
require 'date'
require_relative 'exceptions'

module ImlLogisticsApi
  module Validated

    XML_NAMESPACE = 'http://www.imlogistic.ru/schema/request/v1'

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
        sc = superclass

        if sc.respond_to?(:get_xml_options)
          (sc.get_xml_options || {}).merge(@xml_options || {})
        else
          @xml_options
        end
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
        sc = superclass

        if sc.respond_to?(:fields)
          (sc.fields || {}).merge(@fields)
        else
          @fields
        end
      end

      def get_validator(pattern)
        parsed = parse_pattern(pattern)
        return lambda{|v| true} if parsed.nil?
        symbols, strict, quantity, precision = parsed

        char_patterns = []
        char_patterns << '\D' if symbols.include?('a')
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

        if precision
          match_regex = Regexp.new("^[#{char_patterns.join}]#{quantity_pattern}(\\.\\d{1,#{precision}})?$")
        else
          match_regex = Regexp.new("^[#{char_patterns.join}]#{quantity_pattern}$")
        end

        return lambda {|v| !v.match(match_regex).nil?}
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

      def from_xml(xml)
        options = get_xml_options
        doc = Nokogiri::XML(xml)
        doc.remove_namespaces!
        el_fields = self.fields.reject {|f,opt| options[:type]} # only elementary fields for now
        el = doc.xpath("/#{options[:tag]}")
        res = self.new

        el_fields.each do |field, f_options|
          tag = f_options[:tag] || field
          s_el = el.xpath(tag.to_s)
          res.send("#{field}=", s_el.text) if s_el.any?
        end

        res
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
        Nokogiri::XML::Builder.new(encoding: 'utf-8') do |xml|
          to_xml_internal(xml, XML_NAMESPACE, &block)
        end.to_xml
      else
        to_xml_internal(xml_builder, nil, &block)
      end
    end

    protected

    def to_xml_internal(xml_builder, namespace = nil)
      options = self.class.get_xml_options
      fields = self.class.fields
      add_tag(options[:tag], xml_builder, namespace) do
        fields.each do |f, f_options|
          value = self.send(f)

          if f_options[:type]
            subfield_to_xml(value, f_options, xml_builder)
          else
            elementary_field_to_xml(f, f_options, value, xml_builder)
          end

        end

        yield xml_builder if block_given?
      end
    end

    def subfield_to_xml(value, options, xml_builder)
      if options[:array]
        if options[:tag]
          add_tag(options[:tag], xml_builder) do
            value.each do |item|
              item.to_xml(xml_builder)
            end
          end
        else
          return nil if value.nil?
          value.each do |item|
            item.to_xml(xml_builder)
          end
        end
      else
        value.to_xml(xml_builder)
      end
    end

    def elementary_field_to_xml(field, options, value, xml_builder)
      add_tag(options[:tag] || field, xml_builder) do
        xml_builder.text(format_field(field, value, options)) if value
      end
    end

    def add_tag(tag_name, xml_builder, namespace = nil)
      if ['id', 'comment', 'text', 'type', 'class', 'test'].include?(tag_name.to_s)
        tag_name = tag_name.to_s + '_'
      end

      namespace = namespace ? {'xmlns' => namespace} : nil

      xml_builder.send(tag_name, namespace) do
        yield if block_given?
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

      return if !value

      if value.respond_to?(:valid?)
        validate_subfield(field, value, options)
      else
        validate_elementary_field(field, value, options)
      end
    end

    def validate_subfield(field, value, options)
      if !value.valid?
        value.errors.each do |ce|
          add_error(field, ce[:value], "Error in '#{field}': #{ce[:message]}")
        end
      end
    end

    def validate_elementary_field(field, value, options)
      f_val = format_field(field, value, options)

      if !options[:validator].call(f_val)
        add_error(field, value, "Invalid value '#{f_val}' for field '#{field}' (#{options[:pattern]}).")
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
