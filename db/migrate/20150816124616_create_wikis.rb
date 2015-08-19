class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.belongs_to :game, foreign_key: true

      t.text :body
      t.text :publishers

      t.timestamps null: false
    end

    add_index :wikis, :game_id
  end
end
