FactoryGirl.define do
  factory :label, class: ImlLogisticsApi::Label do
    order_number
    store_name {Faker::Company.name}
    region {Faker::Address.state}
    barcode {Faker::Number.number(12)}
  end
end
