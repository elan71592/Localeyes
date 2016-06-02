User.create!( first_name: "Pan",
              last_name: "Wangperawong",
              location: "NYC",
              email: "pan@panfan.com",
              password: "password"
)

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
                  trip_id: Trip.first.id
)


Tag.create!( name: "coding")

TripTag.create!( trip_id: Trip.first.id,
                 tag_id: Tag.first.id
)

User.create!( first_name: "Sam",
              last_name: "Blackman",
              location: "NYC",
              email: "pansbiggestfan@panfan.com",
              password: "password"
)

UserTrip.create!( trip_id: Trip.first.id,
                  user_id: User.last.id
)

Favorite.create!( user_id: User.first.id,
                  trip_id: Trip.first.id
)

Comment.create!( body: "Great trip!",
                 trip_id: Trip.first.id,
                 user_id: User.last.id )
