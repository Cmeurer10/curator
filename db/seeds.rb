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
course = Course.new(name: Faker::Educator.unique.course)
course.save


# Enrollment and Curatorhsip creation
users.each do |user|
  if user.student?
    Enrollment.create(user, course)
  else
    Curatorship.create(user, course)
  end
  user.save
end

#



def new_user
  User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.unique.last_name,
              email: Faker::Internet.unique.email, username: Faker::Internet.unique.user_name,
              password: 'valid_password', password_confirmation: 'valid_password')
end
