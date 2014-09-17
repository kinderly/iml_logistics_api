FactoryGirl.define do
  factory :address, class: ImlLogisticsApi::Address do
    detail {build(:detail)}
    line {"#{detail.street}, #{detail.house}, #{detail.structure}, #{detail.apartment}"}
    city {Faker::Address.city}
    post_code {rand(100000..999999).to_s}
  end
end

