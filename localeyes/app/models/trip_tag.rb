class TripTag < ActiveRecord::Base
  belongs_to :trip
  belongs_to :tag
end
