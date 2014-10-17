FactoryGirl.define do
  factory :communication, class: ImlLogisticsApi::Communication do
    telephone1 {Faker::PhoneNumber.phone_number}
    telephone2 {Faker::PhoneNumber.cell_phone}
    telephone3 {Faker::PhoneNumber.phone_number}
  end
end
