class Feed < ActiveRecord::Base
  attr_accessible :feed_url

  validates_presence_of :feed_url, :message => ""
end
