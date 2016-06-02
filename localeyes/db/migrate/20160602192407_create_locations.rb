class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.string :place_id
      t.string :street_num, null: false
      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.string :picture_url
      t.string :phone_number
      t.string :website_url
      t.references :trip, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
