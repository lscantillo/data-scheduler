# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin1 = User.create!(
  name: "Admin One",
  email: "admin1@example.com",
  password: "password123",
  role: :admin
)

admin2 = User.create!(
  name: "Admin Two",
  email: "admin2@example.com",
  password: "password123",
  role: :admin
)

puts "2 Admins created"

# create 5 users
5.times do |i|
  User.create!(
    name: "User #{i + 1}",
    email: "user#{i + 1}@example.com",
    password: "password123",
    role: :user
  )
end

puts "5 Users created"
