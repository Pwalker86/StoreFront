# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'

puts "******* Creating Users *****"
3.times do |i|
  u = User.new(email: "user#{i}@email.com", password: "test123")
  if u.save!
    puts "#{u.email} created"
  else
    puts "User not created"
  end
end

puts "******* Creating Admins *****"
3.times do |i|
  a = StoreAdmin.new(email: "admin#{i}@email.com", password: "test123")
  begin
    a.save!
    puts "******** Admin: #{a.email} created ********* "
    s = Store.new(name: "#{a.email} store", location: Faker::Address.city, phone_number: Faker::PhoneNumber.phone_number, email: Faker::Internet.email, store_admin_id: a.id)
    image_uri = URI(Faker::LoremFlickr.image)
    image = image_uri.open
    s.spotlight.attach(io: image, filename: "#{store.name}_image.jpg")
    s.save!
    puts "******** Store: #{s.name} created *********"
      (5..20).to_a.sample.times do |i|
      p = Product.new(name: Faker::Movie.title, price: 100, description: Faker::Lorem.paragraphs(number: (2..5).to_a.sample), store_id: s.id)
      p.save!
      puts "*********** Product: #{ p.name} created **********"
    end
  rescue StandardError => exception
    puts "Something went wrong in Admin creation: #{exception}"
  end

  Product.all.each do |product|
    puts "******* Creating #{product.name} Reviews *****"
    begin
      (10..30).to_a.sample.times do
        product.reviews.new(title: Faker::Lorem.sentence(word_count: 5), body: Faker::Lorem.paragraphs(number: (1..2).to_a.sample))
      end
      product.save!
    puts "*********** Reviews created **********"
    rescue StandardError => exception
      puts "Something went wrong in Review creation: #{exception}"
    end

    puts "******* Creating #{product.name} Tags *****"
    begin
      (2..6).to_a.sample.times do
        product.tag_list << Faker::Adjective.positive
      end
      product.save!
    puts "*********** Tags created **********"
    rescue StandardError => exception
      puts "Something went wrong in Tag creation: #{exception}"
    end

    puts "******* Creating #{product.name} Images *****"
    begin
      (2..6).to_a.sample.times do |i|
        image_uri = URI(Faker::LoremFlickr.image)
        image = image_uri.open
        product.images.attach(io: image, filename: "#{product.name}_image_#{i}.jpg")
        puts "*********** Image created **********"
      end
    rescue StandardError => exception
      puts "Something went wrong in Image creation: #{exception}"
    end
  end
end
