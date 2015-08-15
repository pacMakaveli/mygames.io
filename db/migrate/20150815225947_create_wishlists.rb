class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.string :name
      t.string :description
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end