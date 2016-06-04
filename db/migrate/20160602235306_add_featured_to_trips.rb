class AddFeaturedToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :featured, :boolean
  end
end
