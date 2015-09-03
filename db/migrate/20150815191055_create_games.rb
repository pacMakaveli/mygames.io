class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to :platform,  foreign_key: true

      t.string     :name,        null: false
      t.string     :aliases
      t.text       :description, null: false
      t.attachment :cover

      t.text :themes
      t.text :developers
      t.text :release_platforms
      t.date :release_date

      t.string  :api_endpoint
      t.integer :api_reference,  null: false

      t.timestamps null: false
    end

    add_index :games, :name

    add_index :games, :api_reference
    add_index :games, :api_endpoint

    add_index :games, :platform_id
  end
end
