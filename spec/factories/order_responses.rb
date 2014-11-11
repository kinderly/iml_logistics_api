FactoryGirl.define do
  factory :order_response, class: ImlLogisticsApi::OrderResponse do
    number {generate(:order_number)}
    status 'OK'

    trait :with_barcode do
      barcode_list {build(:barcode_list)}
    end
  end
end
