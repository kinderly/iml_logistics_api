require_relative 'validated'

module ImlLogisticsApi
  class BaseOrder
    include ImlLogisticsApi::Validated

    xml_options tag: 'Order'
    field :number, use: 'R', pattern: 'an..20'
  end
end
