class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.belongs_to :user, foreign_key: true

      t.string :name
      t.text :description

      t.timestamps null: false
    end

    add_index :wishlists, :user_id
  end
end
