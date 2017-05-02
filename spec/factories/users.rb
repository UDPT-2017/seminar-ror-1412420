FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    sequence :email {|n| "#{n}#{Faker::Internet.email}" }
    password '12345678'

    factory :user_with_links do
      transient do
        links_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:link, evaluator.links_count, user: user)
      end
    end
  end
end
