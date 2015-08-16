class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :query,  index: true, null: false
      t.integer :count, index: true, default: 0

      t.timestamps null: false
    end
  end
end
