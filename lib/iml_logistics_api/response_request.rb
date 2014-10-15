require 'nokogiri'
require_relative 'message'
require_relative 'order_response'

module ImlLogisticsApi
  class ResponseRequest
    attr_accessor :message
    attr_accessor :orders

    def self.from_xml(xml)
      doc = Nokogiri::XML(xml)
      res = new
      message_xml = doc.xpath('/ResponseRequest/Message').to_s
      res.message = ::ImlLogisticsApi::Message.from_xml(message_xml)

      res.orders = []
      doc.xpath('/ResponseRequest/Order').each do |node|
        res.orders << ::ImlLogisticsApi::OrderResponse.from_xml(node.to_s)
      end

      res
    end
  end
end
