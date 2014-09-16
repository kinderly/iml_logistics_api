require_relative 'validated'

module ImlLogisticsApi
  class Region
    include ImlLogisticsApi::Validated

    xml_options tag: 'Region'

    field :departure, use: 'R', pattern: 'an..20'
    field :destination, use: 'R', pattern: 'an..20'
  end
end

