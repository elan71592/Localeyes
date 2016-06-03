User.create!( first_name: "Pan",
              last_name: "Wangperawong",
              location: "NYC",
              email: "pan@panfan.com",
              password: "password"
)

users = 20.times.map do
  User.create!( email: Faker::Internet.safe_email,
                password: 'password',
                first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                location: "New York City" )
end

Trip.create!( name: "DBC Tour",
              user_id: User.first.id
)

Location.create!( name: "Dev Bootcamp",
                  address: "48 Wall St, New York, NY, USA",
                  phone_number: "123-456-789",
                  website_url: "http://devbootcamp.com",
                  picture_url: Faker::Avatar.image,
                  personal_note: Faker::Lorem.sentence,
                  duration: Faker::Number.between(1, 10),
                  trip_id: 1
)

Location.create!( name: "Dos Toros",
                  address: "101 Maiden Lane, New York, NY, USA",
                  phone_number: "123-456-789",
                  website_url: "www.dostoros.com",
                  picture_url: Faker::Avatar.image,
                  personal_note: Faker::Lorem.sentence,
                  duration: Faker::Number.between(1, 10),
                  trip_id: 1
)

Location.create!( name: "South Street Seaport",
                  address: "One Seaport Plaza, New York, NY, USA",
                  phone_number: "123-456-789",
                  website_url: "www.southstreetseaport.com/",
                  picture_url: Faker::Avatar.image,
                  personal_note: Faker::Lorem.sentence,
                  duration: Faker::Number.between(1, 10),
                  trip_id: 1
)

Location.create!( name: "Trinity Church",
                  address: "75 Broadway, New York, NY, USA",
                  phone_number: "123-456-789",
                  website_url: "https://www.trinitywallstreet.org/",
                  picture_url: Faker::Avatar.image,
                  personal_note: Faker::Lorem.sentence,
                  duration: Faker::Number.between(1, 10),
                  trip_id: 1
)

Location.create!( name: "Ulysses",
                  address: "95 Pearl St, New York, NY, USA",
                  phone_number: "123-456-789",
                  website_url: "www.ulyssesnyc.com/",
                  picture_url: Faker::Avatar.image,
                  personal_note: Faker::Lorem.sentence,
                  duration: Faker::Number.between(1, 10),
                  trip_id: 1
)


Tag.create!( name: "coding")

TripTag.create!( trip_id: Trip.first.id,
                 tag_id: Tag.first.id
)

UserTrip.create!( trip_id: Trip.first.id,
                  user_id: User.last.id
)


Comment.create!( body: "Great trip!",
                 trip_id: Trip.first.id,
                 user_id: User.last.id )


trips = 20.times.map do
  Trip.create!( name: Faker::Lorem.sentence(3),
                user_id: User.all.sample.id)
end

featured_trips = 5.times.map do
  Trip.create!( name: Faker::Lorem.sentence(3),
                user_id: User.all.sample.id,
                featured: true )
end

locations = 100.times.map do
  Location.create!( name: Faker::Lorem.word,
                    address: Faker::Address.street_address,
                    phone_number: "123-456-789",
                    website_url: Faker::Internet.url('example.com'),
                    picture_url: Faker::Avatar.image,
                    personal_note: Faker::Lorem.sentence,
                    duration: Faker::Number.between(1, 10),
                    trip_id: Trip.all.sample.id)
end

favorites = [Favorite.create!( user_id: 1, trip_id: 1
),Favorite.create!( user_id: 2, trip_id: 1
),Favorite.create!( user_id: 3, trip_id: 2
),Favorite.create!( user_id: 4, trip_id: 2
),Favorite.create!( user_id: 5, trip_id: 6
),Favorite.create!( user_id: 6, trip_id: 3
),Favorite.create!( user_id: 7, trip_id: 4
),Favorite.create!( user_id: 8, trip_id: 6
),Favorite.create!( user_id: 9, trip_id: 4
)]
