FactoryGirl.define do
  factory :order, class: ImlLogisticsApi::Order do
    number {rand(10000..99999).to_s}
    action {
      ImlLogisticsApi::Order::ACTIONS[rand(0..ImlLogisticsApi::Order::ACTIONS.length-1)]
    }
    condition {build(:condition)}
    region {build(:region)}
    consignee {build(:consignee)}
    self_delivery {build(:self_delivery)}
    goods_measure {build(:goods_measure)}
    bar_code {Faker::Number.number(13)}
    goods_items {build_list(:item, rand(1..10))}
  end
end

