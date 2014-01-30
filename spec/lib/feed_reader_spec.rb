require 'spec_helper.rb'

describe FeedReader do
  include FeedReader
  before(:each) do
   @feed = Class.new do
     include FeedReader
   end
  end


  context 'is_valid_feed_url?' do
    it 'should return false for invalid feed-url' do
      @feed.should_receive(:is_valid_feed_url?).with('invalid-url').and_return(false)
      @feed.new.is_valid_feed_url?('invalid').should be_false
    end
  end
end