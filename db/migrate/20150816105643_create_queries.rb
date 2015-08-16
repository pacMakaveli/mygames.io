class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :query, null: false
      t.integer :count, default: 0

      t.timestamps null: false
    end
  end
end
