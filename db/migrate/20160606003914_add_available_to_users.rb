class AddAvailableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :available, :boolean, :default => false
  end
end
