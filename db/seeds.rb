# Create a main sample user.
User.create!(
    name:  "Bobby",
    email: "804962881z@gmail.com",
    password:              "foobar",
    password_confirmation: "foobar",
    admin: true,
    activated: true,
    activated_at: Time.zone.now
)

# Generate a bunch of additional users.
99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(name:  name,
      email: email,
      password:              password,
      password_confirmation: password,
      activated: true,
      activated_at: Time.zone.now)
end

# Microposts
users = User.order(:created_at).first(6)
50.times do 
    content = Faker::Lorem.sentence(word_count: 5)
    users.each { |user| user.microposts.create!(content: content) } 
end

# Follower and following relationships
users = User.all
user = User.first
following = users[2..50]
followers  = users[3..30]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }