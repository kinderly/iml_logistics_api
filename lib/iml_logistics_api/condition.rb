require_relative 'validated'
require_relative 'delivery'

module ImlLogisticsApi
  class Condition
    include ImlLogisticsApi::Validated

    xml_options tag: 'Condition'

    field :service, use: 'R', pattern: 'an..20'
    field :delivery, use: 'R', type: ImlLogisticsApi::Delivery
    field :comment, use: 'O', pattern: 'an..250'

  end
end
