require_relative 'base_order'
require_relative 'product'
require_relative 'barcode_list'

module ImlLogisticsApi
  class OrderResponse < BaseOrder
    field :status, use: 'R', pattern: 'an..19'
    field :sequence, use: 'D', pattern: 'n..8'
    field :not_passed, use: 'D', pattern: 'an..250', tag: 'notPassed'
    field :description, use: 'O', pattern: 'an..250'
    field :posted, use: 'O', pattern: 'n..8'
    field :order_status, use: 'O', pattern: 'n..8', tag: 'orderStatus'
    field :status_date, use: 'O', pattern: 'an10', tag: 'statusDate'
    field :delivery_status, use: 'O', pattern: 'n..8', tag: 'deliveryStatus'
    field :delivered_products, use: 'O', array: true, type: ImlLogisticsApi::DeliveredProduct
    field :returned_products, use: 'O', array: true, type: ImlLogisticsApi::ReturnedProduct
    field :comment, use: 'O', pattern: 'an..250', tag: 'comment'
    field :barcode_list, use: 'O', type: ImlLogisticsApi::BarcodeList

    def barcode
      barcode_list.volumes.first.barcode if barcode_list && barcode_list.volumes && barcode_list.volumes.first
    end
  end
end
