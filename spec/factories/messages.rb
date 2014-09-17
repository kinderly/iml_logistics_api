FactoryGirl.define do
  factory :message, class: ImlLogisticsApi::Message do
    sender {Faker::Number.number(6)}
    recipient {Faker::Number.number(6)}
    issue {DateTime.now}
    reference {Faker::Number.number(10)}
    version 1.0


    factory :test_message do
      test 1
    end
  end
end

