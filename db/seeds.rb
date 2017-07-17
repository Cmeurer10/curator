# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin Creation
if User.all.where(role: 2) < 1
  user = new_user
  user.role = 2
end

# Professor and TA creation
users = []
rand(2..3).times do
  user = new_user
  user.role = 1
  users << user
end

# Student creation
rand(15..25).times do
  users << new_user
end

# Course creation
course = Course.create(name: Faker::Educator.unique.course)

# Enrollment and Curatorship creation
users.each do |user|
  if user.student?
    Enrollment.create(user, course)
  else
    Curatorship.create(user, course)
  end
  user.save
end

# Book creation
2.times do
  Book.create(title: Faker::Book.title, author: Faker::Book.author,
              publisher: Faker::Book.publisher, course: course,
              content: Faker::Lorem.paragraph(7))
end

# Conversation creation
conversations = []
Book.all.each do |book|
  num = rand(2..6)
  num.times do
    conversations << Conversation.create(topic: Faker::Lorem.sentence,
                     start_index: (book.content.length * rand(1..12) / 15).floor,
                     end_index: self.start_index + rand(10..20), book: book,
                     user: users.select { |u| u.student? }.sample)
  end
end

# Post creation
conversations.each do |conv|
  rand(1..3).times do
    Post.create(content: Faker::Lorem.paragraph, conversation: conv,
                user: users.select { |u| u.student? }.sample)
  end
end


def new_user
  User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.unique.last_name,
              email: Faker::Internet.unique.email, username: Faker::Internet.unique.user_name,
              password: 'valid_password', password_confirmation: 'valid_password')
end
