class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.boolean :flagged, default: false
      t.references :user, foreign_key: true
      t.references :flaggable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
