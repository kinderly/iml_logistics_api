FactoryGirl.define do
  factory :label, class: ImlLogisticsApi::Label do
    order_number
    store_name {Faker::Company.name}
    region {ImlLogisticsApi::Region::REGIONS[rand(0..ImlLogisticsApi::Region::REGIONS.length - 1)]}
    barcode {Faker::Number.number(13)}
  end
end
