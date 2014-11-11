require_relative 'validated'

module ImlLogisticsApi
  class Volume
    include ImlLogisticsApi::Validated

    xml_options tag: 'Volume'

    field :position, use: 'R', pattern: 'n..13'
    field :barcode, use: 'O', pattern: 'n..13'
    field :encoded_barcode, use: 'O', pattern: 'an..50', tag: 'encodedBarcode'
    field :encoded_type, use: 'O', pattern: 'an..20', tag: 'encodedType'
  end
end
