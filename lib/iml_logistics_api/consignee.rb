require_relative 'validated'
require_relative 'address'
require_relative 'representative_person'

module ImlLogisticsApi
  class Consignee
    include ImlLogisticsApi::Validated

    xml_options tag: 'Consignee'

    field :address, use: 'R', type: ImlLogisticsApi::Address
    field :representative_person, use: 'R', type: ImlLogisticsApi::RepresentativePerson

    def initialize
      @address = ImlLogisticsApi::Address.new
      @representative_person = ImlLogisticsApi::RepresentativePerson.new
    end
  end
end
