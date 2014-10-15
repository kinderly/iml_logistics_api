require_relative 'validated'

module ImlLogisticsApi
  class Product
    include ImlLogisticsApi::Validated

    field :product_no, use: 'O', pattern: 'an..20', tag: 'productNo'
  end

  class DeliveredProduct < Product
    xml_options tag: 'DeliveredProduct'
  end

  class ReturnedProduct < Product
    xml_options tag: 'ReturnedProduct'
  end
end
