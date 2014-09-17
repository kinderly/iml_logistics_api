FactoryGirl.define do
  factory :consignee, class: ImlLogisticsApi::Consignee do
    address {build(:address)}
    representative_person {build(:representative_person)}
  end
end

