# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User generator function
def new_user
  User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.unique.last_name,
              email: Faker::Internet.unique.email, username: Faker::Internet.unique.user_name,
              password: 'valid_password', password_confirmation: 'valid_password')
end

# Admin Creation
if User.all.where(role: 2).count < 1
  user = new_user
  user.role = 2
  user.save
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
    e = Enrollment.new
    e.user = user
    e.course = course
    e.save
  else
    c = Curatorship.new
    c.user = user
    c.course = course
    c.save
  end
  user.save
end

# # Book creation
# books = []
# 2.times do
#   content = ""
#   rand(5..7).times do
#     content += Faker::Lorem.paragraph(rand(4..7)) + '\n'
#   end
#   books << Book.create(title: Faker::Book.title, author: Faker::Book.author,
#               publisher: Faker::Book.publisher, course: course,
#               content: content[0..-3])
# end
#
# # Conversation creation
# conversations = []
# books.each do |book|
#   num = rand(2..6)
#   num.times do
#     start_index = ((book.content.length * rand(1..12) / 15).floor).to_i
#     conversations << Conversation.create(topic: Faker::Lorem.sentence,
#                      start_index: start_index, end_index: start_index + rand(10..20),
#                      book: book, user: users.select(&:student?).sample)
#   end
# end
#
# # Post creation
# conversations.each do |conv|
#   rand(1..3).times do
#     Post.create(content: Faker::Lorem.paragraph, conversation: conv,
#                 user: users.select(&:student?).sample)
#   end
# end
