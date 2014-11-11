FactoryGirl.define do
  factory :barcode_list, class: ImlLogisticsApi::BarcodeList do
    volumes {build_list(:volume, 1)}
  end
end
