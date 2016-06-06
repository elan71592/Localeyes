class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :user, index: true, foreign_key: true
      t.references :trip, index: true, foreign_key: true
      t.boolean :open, default: true

      t.timestamps null: false
    end
  end
end
