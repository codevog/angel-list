class AddColumnLastPageToLocationTags < ActiveRecord::Migration
  def change
    add_column(:location_tags, :last_page, :integer)
  end

  def down
    remove_column(:location_tags, :last_page)
  end

end
