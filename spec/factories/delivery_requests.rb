FactoryGirl.define do
  factory :delivery_request, class: ImlLogisticsApi::DeliveryRequest do
    message {build(:message)}
    orders {build_list(:order, rand(1..3))}
  end

  factory :test_delivery_request, class: ImlLogisticsApi::DeliveryRequest do
    message {build(:test_message)}
    orders {build_list(:test_order, rand(1..3))}
  end
end
