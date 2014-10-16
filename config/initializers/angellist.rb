puts 'Initialize application'
Dir[File.join(Rails.root, "lib", "*.rb")].each do |path|
  require_dependency path
end

puts 'Configure AngellistApi'
AngellistApi.configure do |config|
  config.access_token = '861ef0fe887ac193d4d71be631d76f8d'
end

puts 'configure application'
Angellist.configure do |config|
  config.root_location_tag_id = 1642
end


