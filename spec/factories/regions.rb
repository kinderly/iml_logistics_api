FactoryGirl.define do
  factory :region, class: ImlLogisticsApi::Region do
    departure {
      ImlLogisticsApi::Region::REGIONS[rand(0..ImlLogisticsApi::Region::REGIONS.length - 1)]
    }

    destination {
     ImlLogisticsApi::Region::REGIONS[rand(0..ImlLogisticsApi::Region::REGIONS.length - 1)]
    }
  end
end

