class RenameColumnsInUserTrips < ActiveRecord::Migration
  def change
    change_table :user_trips do |t|
      t.rename :trip_id, :attended_trip_id
      t.rename :user_id, :attendee_id
    end
  end
end
