FactoryGirl.define do
  sequence :order_number do |n|
    (10000 + n).to_s
  end

  sequence :test_order_number do |n|
    "#{DateTime.now.strftime('test_%d%m%y%H%M%S')}#{n % 10}"
  end


  factory :order, class: ImlLogisticsApi::Order do
    number {generate(:order_number)}
    action {
      ImlLogisticsApi::OrderAction::ACTIONS[rand(0..ImlLogisticsApi::Order::ACTIONS.length-1)]
    }
    condition {build(:condition)}
    region {build(:region)}
    consignee {build(:consignee)}
    self_delivery {build(:self_delivery)}
    goods_measure {build(:goods_measure)}
    bar_code {Faker::Number.number(13)}
    goods_items {build_list(:item, rand(1..10))}

    factory :test_order do
      number {generate(:test_order_number)}
      bar_code nil
    end
  end
end

