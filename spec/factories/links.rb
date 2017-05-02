FactoryGirl.define do
  factory :link do
    full_link Faker::Internet.url
    sequence :short_link do |n|
      "#{SecureRandom.urlsafe_base64(4)}#{n}"
    end
    domain Faker::Internet.domain_name
    link_type 0

    user

    factory :link_with_list_hits  do
      transient do
        number_of_days 5
      end

      after(:create) do |link, evaluator|
        evaluator.number_of_days.times do |n|
          create(:hit, created_at: n.days.ago, link: link)
        end
      end
    end
  end
end
