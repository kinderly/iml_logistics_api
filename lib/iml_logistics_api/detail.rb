require_relative 'validated'

module ImlLogisticsApi
  class Detail
    include ImlLogisticsApi::Validated

    xml_options tag: 'Detail'

    field :street, use: 'D', pattern: 'an..150'
    field :house, use: 'D', pattern: 'an..10'
    field :structure, use: 'O', pattern: 'an..20'
    field :apartment, use: 'D', pattern: 'an..10'

  end
end
