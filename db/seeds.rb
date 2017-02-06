# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Set datas of users and groups
(0...10).each do |i|
  user = User.new
  user.name = Faker::Name.name
  user.mail = Faker::Internet.email
  user.age = i < 5 ? rand(20...40) : rand(40...60)
  user.save
end

group = Group.new
group.name = "young"
group.save

group = Group.new
group.name = "old"
group.save


# Join groups with users
User.where('age < ?', 40).each do |x|
  x.group_ids = 1  # young
end
User.where.not('age < ?', 40).each do |x|
  x.group_ids = 2  # old
end

# Set post
Post.create({user_id: 5, title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph})

# Set likes
post = Post.first
young_users = User.where('age < ?', 40)
young_users_count = young_users.count
young_users_count.times do |x|
  post.likes.create({user_id: young_users[x].id})
end

# Set comments
old_users = User.where.not('age < ?', 40)
old_users_count = old_users.count
old_users_count.times do |x|
  Comment.create({user_id: old_users[x].id, post_id: 1, content: Faker::Lorem.sentence})
end
