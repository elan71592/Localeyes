class AddAllowMessagesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :allow_messages, :boolean, :default => true
  end
end
