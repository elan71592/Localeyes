json.extract! @trip, :id, :name, :user_id, :created_at, :updated_at, :featured

json.locations @trip.locations do |location|
  json.extract! location, :id, :name, :place_id, :street_num, :street, :city, :state, :country, :picture_url, :phone_number, :website_url, :trip_id, :created_at, :updated_at
end