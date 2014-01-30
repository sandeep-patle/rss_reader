require 'spec_helper'

describe Feed do
  context 'Validating feed' do
    before(:each) do
      @feed = FactoryGirl.build(:feed)
    end
    it 'should return true for presence of feed_url' do
      @feed.valid?.should be_true
    end
    it 'should return false for blank feed_url' do
      @feed.feed_url = ''
      @feed.valid?.should be_false
    end
  end
end
