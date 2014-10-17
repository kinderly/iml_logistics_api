FactoryGirl.define do
  factory :delivery, class: ImlLogisticsApi::Delivery do
    issue {(Time.now + rand(5..15) * 24 * 60 * 60).to_date}
    time_from '10:00:00'
    time_to '18:00:00'
    comment {Faker::Hacker.say_something_smart}
  end
end
