FactoryGirl.define do
  factory :goods_measure, class: ImlLogisticsApi::GoodsMeasure do
    weight {rand(0.51..7.35).round(2)}
    volume {rand(0.51..7.35).round(2)}
    amount {rand(0.51..7.35).round(2)}
    statistical_value {rand(0.51..7.35).round(2)}
  end
end
