class AddGiantBombReferenceToGames < ActiveRecord::Migration
  def change
    add_column :games, :reference_id, :integer
  end
end
