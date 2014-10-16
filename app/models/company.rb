class Company < ActiveRecord::Base
  include Concerns::AngelApiListHandler

  serialize :locations, Array
  serialize :markets,   Array

  class << self
    def load_with_angel_api
      LocationTag.invoke_tags_for_companies.each do |tag|
        tag.set_status(1)
        _ids = simple_list_handler(:get_tag_startups, tag.ang_list_id, array_name: 'startups') do |items, ids, page_number|
          items.each do |item|
            begin
              next if item[:hidden]
              if exists?(ang_list_id: item['id'])
                p "Already exists: #{item['id']}"
                next
              end

              _angle_object = {ang_list_id: item['id'], name: item[:name], company_url: item[:company_url],
                               locations: item[:locations].map {|loc_item| loc_item['display_name']}, markets: item[:markets].map {|loc_item| loc_item['display_name']}}

              unless (fundraising = item['fundraising']).nil?
                if fundraising.is_a?(Hash)
                  _angle_object.merge!(fundraising)
                end
              end

              create!(_angle_object)
              ids << item['id']
              p "Added new company: #{item['id']}"
            rescue Exception => error
              p "Error: #{item['id']} error: #{error.message}"
            end
          end
          tag.set_last_company_page(page_number)
        end
        tag.complete_tag(_ids.size)

        puts "Companies count: #{count()}"
        puts "Complete tag ID: #{tag.ang_list_id}"
      end
    end
  end

end
