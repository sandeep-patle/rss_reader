class Feed < ActiveRecord::Base
  attr_accessible :feed_url
  #attr_accessor :title, :last_modified, :url

  #validates :feed_url, :url => true

  validates_presence_of :feed_url, :message => "Please enter valid feed URL."
end
