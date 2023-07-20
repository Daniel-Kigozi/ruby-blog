class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.text :text

      t.timestamps
    end
    add_foreign_key :comments, :posts, column: :post_id
  end
end
