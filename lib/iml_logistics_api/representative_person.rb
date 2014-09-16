require_relative 'validated'

module ImlLogisticsApi
  class RepresentativePerson
    include ImlLogisticsApi::Validated

    xml_options tag: 'RepresentativePerson'

    field :name, use: 'R', pattern: 'n..250'
    field :telephone1, use: 'R', pattern: 'an..35'
    field :telephone2, use: 'O', pattern: 'an..35'
    field :telephone3, use: 'O', pattern: 'an..30'
  end
end

