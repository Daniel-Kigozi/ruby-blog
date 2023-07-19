class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo_link
      t.text :bio
      t.integer :posts_counter

      t.index :name
      t.timestamps
    end
  end
end
