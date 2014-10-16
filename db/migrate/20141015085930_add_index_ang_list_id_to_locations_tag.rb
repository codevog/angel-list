class AddIndexAngListIdToLocationsTag < ActiveRecord::Migration
  def change
    add_index(:location_tags, [:ang_list_id], unique: true )
  end

  def down
    remove_index(:location_tags, column: :ang_list_id)
  end
end
