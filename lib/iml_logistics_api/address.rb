require_relative 'validated'
require_relative 'detail'

module ImlLogisticsApi
  class Address
    include ImlLogisticsApi::Validated

    xml_options tag: 'Address'

    field :line, use: 'D', pattern: 'an..250'
    field :detail, use: 'D', type: ImlLogisticsApi::Detail
    field :city, use: 'D', pattern: 'an..50'
    field :post_code, use: 'O', pattern: 'n6', tag: 'postCode'

    def initialize
      @detail = ImlLogisticsApi::Detail.new
    end
  end
end
