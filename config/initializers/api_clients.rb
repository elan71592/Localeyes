GOOGLE_CLIENT = GooglePlaces::Client.new( ENV[ 'GOOGLE_PLACES_KEY' ] )

CLOUDINARY_AUTH = {
                    cloud_name: "localeyes-trips",
                    api_key:    ENV[ "CLOUDINARY_KEY" ],
                    api_secret: ENV[ "CLOUDINARY_SECRET" ]
                  }
