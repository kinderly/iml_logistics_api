require_relative 'validated'
require_relative 'communication'

module ImlLogisticsApi
  class RepresentativePerson
    include ImlLogisticsApi::Validated

    xml_options tag: 'RepresentativePerson'

    field :name, use: 'R', pattern: 'an..250'
    field :communication, use: 'R', type: ImlLogisticsApi::Communication

    def initialize
      @communication = ImlLogisticsApi::Communication.new
    end
  end
end

