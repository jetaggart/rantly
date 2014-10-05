class CreateRants < ActiveRecord::Migration
  def change
    create_table :rants do |t|
      t.string :title
      t.text :body
      t.integer :author_id
      t.timestamps
    end
  end
end
