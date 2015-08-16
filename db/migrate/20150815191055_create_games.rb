class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.reference :user,        index: true, null: false

      t.string :name,           null: false
      t.text :description,      null: false
      t.string :platform
      t.attachment :cover

      t.string :endpoint
      t.integer :reference_id,  index: true, null: false

      t.timestamps null: false
    end
  end
end
