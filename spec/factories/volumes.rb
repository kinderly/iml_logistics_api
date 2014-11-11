FactoryGirl.define do
  factory :volume, class: ImlLogisticsApi::Volume do
    position 1
    barcode '123456789012'
    encoded_barcode 'MBON'
    encoded_type 'EAN13'
  end
end
