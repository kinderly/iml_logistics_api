FactoryGirl.define do
  factory :representative_person, class: ImlLogisticsApi::RepresentativePerson do
    name {Faker::Name.name}
    telephone1 {Faker::PhoneNumber.phone_number}
    telephone2 {Faker::PhoneNumber.cell_phone}
    telephone3 {Faker::PhoneNumber.phone_number}
  end
end
