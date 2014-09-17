FactoryGirl.define do
  factory :self_delivery, class: ImlLogisticsApi::SelfDelivery do
    delivery_point {Faker::Lorem.characters(4)}
    storage_period {rand(0..24)}
  end
end
