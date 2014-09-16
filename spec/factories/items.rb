FactoryGirl.define do
  factory :item, class: ImlLogisticsApi::Item do
    product_no {'sku_' + rand(10000..99999).to_s}
    product_name Faker::Commerce.product_name
    product_variant Faker::Commerce.color
    product_barcode '1234567890123'
    amount_line {Faker::Commerce.price}
    statistical_value_line {Faker::Commerce.price}
  end
end
