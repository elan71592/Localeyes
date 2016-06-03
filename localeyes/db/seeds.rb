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
                  place_id: "ChIJMeHOVhZawokRVf8JTzCVV2M",
                  street_num: "48",
                  street: "Wall St",
                  city: "New York",
                  state: "NY",
                  country: "USA",
                  website_url: "http://devbootcamp.com",
                  trip_id: 1
)

Location.create!( name: "Dos Toros",
                  place_id: "ChIJV7y41hdawokRCJBkt8qIKI4",
                  street_num: "101",
                  street: "Maiden Lane",
                  city: "New York",
                  state: "NY",
                  country: "USA",
                  website_url: "www.dostoros.com",
                  trip_id: 1
)

Location.create!( name: "South Street Seaport",
                  place_id: "ChIJyQScHT1awokRxd_fSCD5aWM",
                  street_num: "One",
                  street: "Seaport Plaza",
                  city: "New York",
                  state: "NY",
                  country: "USA",
                  website_url: "www.southstreetseaport.com/",
                  trip_id: 1
)

Location.create!( name: "Trinity Church",
                  place_id: "ChIJbVfZzhBawokRnmCT-muojBA",
                  street_num: "75",
                  street: "Broadway",
                  city: "New York",
                  state: "NY",
                  country: "USA",
                  website_url: "https://www.trinitywallstreet.org/",
                  trip_id: 1
)

Location.create!( name: "Ulysses",
                  place_id: "ChIJV_vNLhRawokRt36u5nIPaVw",
                  street_num: "95",
                  street: "Pearl St",
                  city: "New York",
                  state: "NY",
                  country: "USA",
                  website_url: "www.ulyssesnyc.com/",
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
                    place_id: "googleplaceid",
                    street_num: rand(1..500).to_s,
                    street: Faker::Address.street_name,
                    city: "New York",
                    state: "NY",
                    country: "USA",
                    website_url: Faker::Internet.url('example.com'),
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