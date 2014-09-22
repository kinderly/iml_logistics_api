FactoryGirl.define do
  factory :message, class: ImlLogisticsApi::Message do
    sender {Faker::Number.number(6)}
    recipient {Faker::Number.number(6)}

    factory :test_message do
      test 1
    end
  end
end

