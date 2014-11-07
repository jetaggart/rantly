class AddDisabledToUsers < ActiveRecord::Migration
  def change
    add_column :users, :disabled, :boolean, :null => false, :default => false
  end
end
