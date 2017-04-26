# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create({
    name: 'Austin',
    email: 'phanphuocdt@gmail.com',
    password: '12345678'
  })

10.times do |n|
  User.create({
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: '12345678'
    })
end

20.times do |n|
  Link.create({
      full_link: Faker::Internet.url,
      short_link: SecureRandom.urlsafe_base64(5),
      domain: Faker::Internet.domain_name,
      user_id: 1,
      created_at: Faker::Time.between(30.days.ago, Date.today, :all)
    })
end

20.times do |n|
  link_id = n + 1
  20.times do
    Hit.create({
        ip_address: Faker::Internet.ip_v4_address,
        location: Faker::Address.country.downcase,
        link_id: link_id,
        latitude: Faker::Address.latitude,
        longitude: Faker::Address.longitude,
        created_at: Faker::Time.between(30.days.ago, Date.today, :all)
      })
  end
end
