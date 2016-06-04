class UserTrip < ActiveRecord::Base
  belongs_to :attendee, class_name: "User"
  belongs_to :attended_trip, class_name: "Trip"

  validates :attendee_id, presence: true
  validates :attended_trip_id, presence: true
end
