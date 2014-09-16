require_relative 'validated'

module ImlLogisticsApi
  class SelfDelivery
    include ImlLogisticsApi::Validated

    xml_options tag: 'SelfDelivery'

    field :delivery_point, tag: 'deliveryPoint', use: 'D', pattern: 'an4'
    field :storage_period, tag: 'storagePeriod', use: 'O', pattern: 'n..2'
  end
end

