class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :website_url
      t.string :picture_url
      t.string :personal_note
      t.string :duration
      t.float :latitude
      t.float :longitude
      t.references :trip, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
