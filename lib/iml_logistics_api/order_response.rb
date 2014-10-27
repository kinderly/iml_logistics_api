require_relative 'base_order'
require_relative 'product'
module ImlLogisticsApi
  class OrderResponse < BaseOrder
    field :status, use: 'R', pattern: 'an..19'
    field :sequence, use: 'D', pattern: 'n..8'
    field :not_passed, use: 'D', pattern: 'an..250', tag: 'notPassed'
    field :description, use: 'O', pattern: 'an..250'
    field :barcode, use: 'O', pattern: 'n13'
    field :encoded_barcode, use: 'O', pattern: 'an..50', tag: 'encodedBarcode'
    field :encoded_type, use: 'O', pattern: 'an..20', tag: 'encodedType'
    field :posted, use: 'O', pattern: 'n..8'
    field :order_status, use: 'O', pattern: 'n..8', tag: 'orderStatus'
    field :status_date, use: 'O', pattern: 'an10', tag: 'statusDate'
    field :delivery_status, use: 'O', pattern: 'n..8', tag: 'deliveryStatus'
    field :delivered_products, use: 'O', array: true, type: ImlLogisticsApi::DeliveredProduct
    field :returned_products, use: 'O', array: true, type: ImlLogisticsApi::ReturnedProduct
    field :comment, use: 'O', pattern: 'an..250', tag: 'comment'
  end
end
