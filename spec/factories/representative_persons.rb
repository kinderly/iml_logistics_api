FactoryGirl.define do
  factory :representative_person, class: ImlLogisticsApi::RepresentativePerson do
    name {Faker::Name.name}
    communication {build(:communication)}
  end
end
