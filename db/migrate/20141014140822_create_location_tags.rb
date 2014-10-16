class CreateLocationTags < ActiveRecord::Migration
  def change
    create_table :location_tags do |t|
      t.column :ang_list_id, :integer, null: false
      t.column :name, :string, limit: 50
      t.column :display_name, :string, limit: 70
      t.column :process_status, :integer, default: 0 # 0 - wait 1 - in-progress 2 - completed
      t.column :processed_users, :integer

      t.column :statistic_users, :integer
      t.timestamps
    end
  end

  def down
    drop_table :location_tags
  end
end
