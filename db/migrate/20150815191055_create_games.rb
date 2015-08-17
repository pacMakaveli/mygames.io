class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to :platform,  foreign_key: true

      t.string :name,          null: false
      t.string :aliases
      t.text :description,     null: false
      t.attachment :cover

      t.string :platforms
      t.string :endpoint
      t.integer :reference_id, null: false

      t.date :release_date
      t.timestamps null: false
    end

    add_index :games, :name
    add_index :games, :reference_id
    add_index :games, :endpoint

    add_index :games, :platform_id
  end
end
