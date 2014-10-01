class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.integer :type_of_ranter
      t.timestamps
    end
  end
end
