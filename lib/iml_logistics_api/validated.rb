require_relative 'exceptions'

module ImlLogisticsApi
  module Validated
    attr_reader :errors

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def field(*args)
        options = extract_options(args)
        @fields ||= {}

        options[:validator] = get_validator(options[:pattern])
        args.each do |field|
          @fields[field] = options
          attr_accessor field
        end
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
          return lambda {|v| !v.match(match_regex).nil?}
        else
          if precision
            max_decimal = 10 ** quantity_decimal_length
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

      @fields.each do |field, options|
        value = self.send(field)
        validate_field(field, value, options)
      end

      errors.empty?
    end

    protected

    def validate_field(field, value, options)
      if !options[:validator].call(value)
        add_error(field, value, "Invalid value '#{value}' for field '#{field}.")
      end
    end

    def add_error(field, value, message)
      @errors << {
        field: fiels,
        value: value,
        message: message
      }
    end
  end # Validated
end # ImlLogisticsApi
