require_relative 'validated'
require_relative 'volume'

module ImlLogisticsApi
  class BarcodeList
    include ImlLogisticsApi::Validated

    xml_options tag: 'BarcodeList'

    field :volumes, array: true, type: ImlLogisticsApi::Volume

    def initialize
      @volumes = []
    end
  end
end
