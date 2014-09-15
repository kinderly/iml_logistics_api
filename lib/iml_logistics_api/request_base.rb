require 'nokogiri'
require_relative 'base'

module ImlLogisticsApi
  class RequestBase < Base
    def to_xml

      builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml_builder|
        yield xml_builder if block_given?
      end

      builder.to_xml
    end
  end
end
