FactoryGirl.define do
  factory :detail, class: ImlLogisticsApi::Detail do
    street {Faker::Address.street_name}
    house {Faker::Address.building_number}
    structure {Faker::Address.building_number}
    apartment {Faker::Address.secondary_address}
  end
end

