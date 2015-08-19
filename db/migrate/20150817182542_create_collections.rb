class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.belongs_to :user, null: false
      t.belongs_to :game, null: false

      t.timestamps null: false
    end

    add_index :collections, :user_id
    add_index :collections, :game_id
  end
end
