FactoryGirl.define do
  factory :delivery_request, class: ImlLogisticsApi::DeliveryRequest do
    message {build(:message)}
    orders {build_list(:order, rand(1..3))}

    factory :test_delivery_request do
      message {build(:test_message)}
    end
  end
end
