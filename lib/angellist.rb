require 'angellist_api/client/al_tags'
module Angellist

  def self.configure
    yield self
  end

  mattr_accessor :root_location_tag_id
  @@root_location_tag_id ||= 0

end