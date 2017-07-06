User.create!(name:  "Admin",
             email: "admin@mail.com",
             password:              "qwerqwer",
             password_confirmation: "qwerqwer",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "user-#{n+1}@mail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

100.times do |n|
  name = Faker::Book.title
  author = Faker::Book.author
  description = Faker::Lorem.sentence(25)
  Book.create!(name:        name,
               author:      author,
               description: description)
end
