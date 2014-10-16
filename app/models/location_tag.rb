class LocationTag < ActiveRecord::Base
  include Concerns::AngelApiListHandler

  class << self
    def load_with_angel_site(locations_tag_id=Angellist.root_location_tag_id)
      _ids = simple_list_handler(:get_tag_children,locations_tag_id, array_name: 'children') do |items, ids, page_number|
        items.each do |item|
          begin
            if item['statistics']['all']['startups'].to_i == 0
              next
            end

            ids << item['id']
            if exists?(ang_list_id: item['id'])
              p "Already exists: #{item['id']}"
              next
            end
            create!({ang_list_id: item['id'], name: item[:name], display_name: item['display_name'], statistic_users: item['statistics']['all']['users']})

            p "Added new Location tag: #{item['id']}"
          rescue Exception => error
            p "Error new Location tag: #{item['id']} error: #{error.message}"
          end
        end
      end

      #################
      _ids.each do |child_id|
        load_with_angel_site(child_id)
      end
    end

    def invoke_tags_for_companies
      where.not(statistic_users: 0).where(process_status: [0, 1]).all(:order => "process_status DESC, statistic_users")
    end
  end


  def set_status(status)
    if  self.process_status != status
      self.process_status = status
      self.save!
    end
  end

  def complete_tag(rows_count)
    self.process_status = 2
    self.processed_users = rows_count
    self.save!
  end

  def set_last_company_page(last_page)
    if self.last_page |= last_page
      self.last_page = last_page
      self.save!
      puts "Saving new page: #{last_page}"
    end
  end
end
