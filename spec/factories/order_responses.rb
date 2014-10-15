FactoryGirl.define do
  factory :order_response, class: ImlLogisticsApi::OrderResponse do
    number {generate(:order_number)}
    status 'OK'
    barcode '123456789012'
    encoded_barcode 'MBON'
    encoded_type 'EAN13'
  end
end
