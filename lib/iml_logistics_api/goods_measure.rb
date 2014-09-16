require_relative 'validated'

module ImlLogisticsApi
  class GoodsMeasure
    include ImlLogisticsApi::Validated

    xml_options tag: 'GoodsMeasure'

    field :weight, use: 'O', pattern: 'n..18,2'
    field :volume, use: 'R', pattern: 'n..18,2'
    field :amount, use: 'D', pattern: 'n..18,2'
    field :statistical_value, use: 'D', pattern: 'n..18,2', tag: 'statisticalValue'
  end
end

