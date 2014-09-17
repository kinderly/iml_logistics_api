FactoryGirl.define do
  factory :region, class: ImlLogisticsApi::Region do
    departure {
      r = nil
      loop do
        r = Faker::Address.state
        break if r.length <= 20
      end
      r
    }

    destination {
      r = nil
      loop do
        r = Faker::Address.state
        break if r.length <= 20
      end
      r
    }
  end
end

