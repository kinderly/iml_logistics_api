FactoryGirl.define do
  factory :order_action, class: ImlLogisticsApi::OrderAction do
    number {generate(:order_number)}
    action  {
      ImlLogisticsApi::OrderAction::ACTIONS[rand(0..ImlLogisticsApi::Order::ACTIONS.length-1)]
    }
  end
end

