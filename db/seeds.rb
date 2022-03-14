# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# require "open-uri"

# # Creat some users
# if Rails.env == 'development'
#   puts "Destroying all data in db"
#   User.destroy_all
#   Event.destroy_all
#   Booking.destroy_all
#   puts "Finished destroying all data in db"
# end

# puts "Creating some users"
# ervina = User.create!(
#   email: 'ervina@mail.com',
#   password: 'secret',
#   first_name: 'Ervina',
#   last_name: 'Theresa'
# )

# sony = User.create!(
#   email: 'sony@mail.com',
#   password: 'secret',
#   first_name: 'Sony',
#   last_name: 'Tamang'
# )

# njoroge = User.create!(
#   email: 'njoroge@mail.com',
#   password: 'secret',
#   first_name: 'Njoroge',
#   last_name: 'Kimani'
# )

# sid = User.create!(
#   email: 'sid@mail.com',
#   password: 'secret',
#   first_name: 'Sid',
#   last_name: 'Lewagon'
# )
# puts " Finished creating users"

# images = [
#   'https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
#   'https://images.unsplash.com/photo-1499028344343-cd173ffc68a9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8Zm9vZHxlbnwwfDB8MHx8&auto=format&fit=crop&w=800&q=60',
#   'https://images.unsplash.com/photo-1493770348161-369560ae357d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Zm9vZHxlbnwwfDB8MHx8&auto=format&fit=crop&w=800&q=60',
#   'https://images.unsplash.com/photo-1476224203421-9ac39bcb3327?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGZvb2R8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
#   'https://c4.wallpaperflare.com/wallpaper/690/564/924/meat-4k-hd-for-desktop-wallpaper-preview.jpg',
#   'https://images.unsplash.com/photo-1588644525273-f37b60d78512?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bmVwYWxpJTIwZm9vZHxlbnwwfHwwfHw%3D&w=1000&q=80',
#   'https://images.unsplash.com/photo-1593252719532-53f183016149?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bmVwYWxpJTIwZm9vZHxlbnwwfHwwfHw%3D&w=1000&q=80',
#   'https://images.squarespace-cdn.com/content/v1/53a05cdee4b0c1bc44841a7b/1542172071935-2BDLZXWL2JNBIPYURZSV/101+Food+Photography+Tips',
#   'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80',
#   'https://images.unsplash.com/photo-1432139509613-5c4255815697?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=985&q=80',
#   'https://images.unsplash.com/photo-1565299507177-b0ac66763828?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1022&q=80'
# ]

# puts "Creating events"
# # Create some events
# User.all.each do |user|
#   5.times do |i|
#     number = i + 1
#     start = DateTime.now.beginning_of_hour + number.day
#     event = Event.create(
#       user: user,
#       name: Faker::Food.dish,
#       price: rand(5..15),
#       capacity: rand(5..15),
#       description: Faker::Food.description,
#       cuisine: Faker::Food.ethnic_category,
#       start_time: start,
#       end_time: start + 2.hours,
#       location: Faker::Address.country,
#     )

#     puts "Event created - #{event.name}"
#     puts "Adding photos to event..."
#     images.each do |_image_url|
#       random_image = images.sample
#       file = URI.open(random_image)
#       event.photos.attach(io: file, filename: random_image, content_type: 'image/png')
#     end
#     puts "Finished adding photos to event"
#   end
# end

# puts "Creating bookings"
# # Create some bookings
# User.all.each do |user|
#   10.times do |i|
#     id = i + 1
#     event = Event.all.sample
#     # event = Event.find(id)
#     # ...
#     booking = Booking.create(
#       user: user,
#       event: event,
#       noguest: rand(5..15),
#     )
#   end
# end
# puts "Finished creating everything :D"
