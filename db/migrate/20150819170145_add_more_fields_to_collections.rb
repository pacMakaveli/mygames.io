class AddMoreFieldsToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :rating, :integer, default: 0
    add_column :collections, :platform, :string

    add_index :collections, :rating
    add_index :collections, :platform
  end
end
