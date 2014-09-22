require_relative 'validated'
require_relative 'order'
require_relative 'message'

module ImlLogisticsApi
  class DeliveryRequest
    include ImlLogisticsApi::Validated

    xml_options tag: 'DeliveryRequest'
    field :message, use: 'R', type: ImlLogisticsApi::Message
    field :orders, use: 'R', array: true, type: ImlLogisticsApi::Order

    def initialize
      @orders = []
    end

    def order_numbers
      self.orders.map(&:number)
    end

    def filename
      "#{self.order_numbers.join("_")}.xml"
    end
  end
end

