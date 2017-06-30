require_relative 'validated'

module ImlLogisticsApi
  class Item
    include ImlLogisticsApi::Validated

    xml_options tag: 'Item'

    field :product_no, use: 'R', pattern: 'an..20', tag: 'productNo'
    field :product_name, use: 'O', pattern: 'an..250', tag: 'productName'
    field :product_variant, use: 'O', pattern: 'an..30', tag: 'productVariant'
    field :product_barcode, use: 'O', pattern: 'an..50', tag: 'productBarCode'
    field :coupon_code, use: 'O', pattern: 'an..80', tag: 'couponCode'
    field :discount, use: 'D',pattern: 'n..18,2'
    field :weight_line, use: 'O', pattern: 'n..18,2', tag: 'weightLine'
    field :amount_line, use: 'D', pattern: 'n..18,2', tag: 'amountLine'
    field :statistical_value_line, use: 'D', pattern: 'n..18,2', tag: 'statisticalValueLine'
    field :delivery_service, use: 'O', pattern: 'n..8', tag: 'deliveryService'
    field :vat_rate, use: 'R', pattern: 'n..2', tag: 'VATRate'
    field :vat_amount, use: 'R', pattern: 'n..18,2', tag: 'VATAmount'
  end
end

