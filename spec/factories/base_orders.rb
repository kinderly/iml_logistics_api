FactoryGirl.define do
  factory :base_order, class: ImlLogisticsApi::BaseOrder do
    number {generate(:order_number)}
  end
end

