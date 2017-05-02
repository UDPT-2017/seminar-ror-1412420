FactoryGirl.define do
  factory :hit do
    ip_address Faker::Internet.ip_v4_address
    location Faker::Address.country.downcase
    latitude Faker::Address.latitude
    longitude Faker::Address.longitude
    created_at Faker::Time.between(30.days.ago, Date.today, :all)

    link
  end
end
