json.extract! @trip, :id, :name, :user_id, :created_at, :updated_at, :featured

json.locations @trip.locations do |location|
  json.extract! location, :id, :name, :phone_number, :website_url, :picture_url, :personal_note, :latitude, :longitude, :duration, :trip_id, :created_at, :updated_at
end
