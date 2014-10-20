require_relative 'validated'

module ImlLogisticsApi
  class Delivery
    include ImlLogisticsApi::Validated

    xml_options tag: 'Delivery'

    field :issue, use: 'R', pattern: 'an10'
    field :time_from, use: 'O', pattern: 'an8', tag: 'timeFrom'
    field :time_to, use: 'O', pattern: 'an8', tag: 'timeTo'
  end
end
