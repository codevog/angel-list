
namespace :angellist do

  desc "Load location tags"
  task :load_tags => :environment do
    _root_locations_tags = [2687, 2397, 2369, 2194, 2163, 2006, 1921, 1830, 1824, 1782, 1741, 1717, 1716, 1641]
    LocationTag.find_each do |tag|
      if _root_locations_tags.include?(tag.ang_list_id)
        tag.process_status = 0
        tag.processed_users = nil
        tag.save!
      else
        tag.destroy
      end
    end

    _root_locations_tags.each do |num|
      LocationTag.load_with_angel_site(num)
    end
    p RUBY_VERSION
    p 'Foo'
  end

  desc "Load companies"
  task :load_companies => :environment do
    puts "Begin process"
    Company.load_with_angel_api
    puts "End  process"
  end


end
