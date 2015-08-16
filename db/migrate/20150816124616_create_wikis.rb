class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.belongs_to :games, index: true, foreign_key: true

      t.string :genre
      t.text :description
      t.string :theme

      t.date :release_date

      t.timestamps null: false
    end
  end
end
