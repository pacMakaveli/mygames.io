class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.reference :games, index: true, null: false

      t.string :genre
      t.text :description
      t.string :theme

      t.date :release_date

      t.timestamps null: false
    end
  end
end
