require_relative 'request_base'

module ImlLogisticsApi
  class DeliveryRequest < RequestBase
    def to_xml
      super do |xml_builder|
        xml_builder.send('DeliveryRequest')
        yield xml_builder
      end
    end
  end
end
