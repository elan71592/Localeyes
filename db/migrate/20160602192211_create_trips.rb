class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name, null: false
      t.references :user, index: true, foreign_key: true
      t.string :city
      t.string :state
      t.string :country
      t.timestamps null: false
    end
  end
end
