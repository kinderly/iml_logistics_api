FactoryGirl.define do
  factory :condition, class: ImlLogisticsApi::Condition do
    service {
      vals = ImlLogisticsApi::Condition::SERVICES.keys
      vals[rand(0..vals.length - 1)]
    }
    delivery {build(:delivery)}
  end
end


