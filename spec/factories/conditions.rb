FactoryGirl.define do
  factory :condition, class: ImlLogisticsApi::Condition do
    service {"#{rand(10..99)}KO"}
    delivery {build(:delivery)}
    comment {Faker::Hacker.say_something_smart}
  end
end


