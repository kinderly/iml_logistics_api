require 'nokogiri'

module ImlLogisticsApi
  module Lists
    def self.parse_regions(xml)
      parse_list(xml, 'Region')
    end

    def self.parse_self_delivery(xml)
      parse_list(xml, 'SelfDelivery', {
        code: 'Code',
        address: 'Addresse', # sic!
        post_code: 'PostCode',
        region: 'Region',
        note: 'Note'
      })
    end

    def self.parse_service(xml)
      parse_list(xml, 'Service')
    end

    def self.parse_delivery_statuses(xml)
      parse_list(xml, 'DeliveryStatus')
    end

    def self.parse_order_statuses(xml)
      parse_list(xml, 'OrderStatus')
    end

    def self.parse_api_actions(xml)
      parse_list(xml, 'API_Action')
    end

    def self.parse_api_responses(xml)
      parse_list(xml, 'API_Response')
    end

    def self.parse_list(xml, node, field_map = {code: 'Code', description: 'Description'})
      doc = Nokogiri::XML(xml)
      doc.xpath("/List/#{node}/Item").map do |item|
        res_hash = {}
        field_map.each do |k, v|
          res_hash[k] = item.xpath(v).text
        end
        res_hash
      end
    end
  end
end
