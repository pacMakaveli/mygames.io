class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.belongs_to :game, foreign_key: true

      t.text :body

      t.string :theme
      t.string :developer
      t.string :publisher

      t.timestamps null: false
    end

    add_index :wikis, :game_id
  end
end
