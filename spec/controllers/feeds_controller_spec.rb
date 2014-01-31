require "spec_helper"

describe FeedsController do
  describe "GET New" do
    it "@feed should not be blank" do
      get :new
      assigns(:feed).should_not be_blank
      assigns(:feed).should be_a Feed
    end

    it 'renders the new template' do
      get :new
      response.should render_template("new")
    end
  end

  describe 'GET Index' do
    it 'should render index page' do
      get :index
      response.should render_template('index')
    end

    it 'should return all feeds for available feed-urls' do
      feed_urls = ["http://feeds.feedburner.com/PaulDixExplainsNothing", "http://feeds.feedburner.com/trottercashion"]
      feed_urls.each do |url|
        FactoryGirl.create(:feed, feed_url: url)
      end
      get :index
      assigns(:feeds).size.should eq feed_urls.size

    end
  end

  describe "POST Create" do
    context 'for Valid feed-url'do
      sample_url = 'http://feeds.feedburner.com/PaulDixExplainsNothing'
      it 'Feed should increment by 1' do
          expect {
            post :create, {:feed => {:feed_url=> sample_url}}
          }.to change(Feed, :count).by(1)
      end

      it 'Valid Feed should be saved ' do
        post :create, {:feed => {:feed_url=> sample_url}}

        assigns(:feed).new_record?.should be_false
      end

      it 'Valid Feed url should be saved and assigns to feed object' do
        post :create, {:feed => {:feed_url=> sample_url}}
        assigns(:feed).feed_url.should == sample_url
      end

      it 'should redirect to show' do

          post :create, {:feed => {:feed_url=> sample_url}}
         response.should redirect_to(feeds_url)
      end
    end

    context 'for Invalid feed-url' do
      sample_url = 'http://feeds.feedburner.com/PaulDixExplainsNothingteston'
      it 'Feed should not increment by 1' do
        expect {
          post :create, {:feed => {:feed_url=> sample_url}}
        }.to change(Feed, :count).by(0)
      end

      it 'Valid Feed should not be saved ' do
        post :create, {:feed => {:feed_url=> sample_url}}
        assigns(:feed).new_record?.should be_true
      end

      it 'InValid Feed url should not be saved and returns with error message' do
        post :create, {:feed => {:feed_url=> sample_url}}
        assigns(:feed).feed_url.should == sample_url
        flash.should_not be_empty
      end

      it 'should render new template' do
          post :create, {:feed => {:feed_url=> sample_url}}
        response.should render_template('new')
      end
    end
  end

  describe "PUT Update" do
    before(:each) do
      @feed = FactoryGirl.create(:feed)
    end
    context 'For valid feed-url' do
      sample_url = 'http://feeds.feedburner.com/PaulDixExplainsNothing'

      it 'should redirect to index page' do
        put :update, :id => @feed.id, :feed =>{:feed_url => sample_url}
        response.should redirect_to(feeds_url)
      end

      it 'feed_url should be updated' do
        put :update, :id => @feed.id, :feed => {:feed_url => sample_url}
        @feed.reload
        @feed.feed_url.should == sample_url
      end
    end

    context 'For invalid feed-url' do
      sample_url = 'http://feeds.feedburner.com/PaulDixExplainsNothingteston'

      it 'should redirect to index page' do
        put :update, :id => @feed.id, :feed =>{:feed_url => sample_url}
        response.should render_template('edit')
      end

      it 'feed_url should be updated' do
        put :update, :id => @feed.id, :feed => {:feed_url => sample_url}
        flash.should_not be_empty
      end
    end
  end

  describe 'Get Show all posts' do
    it 'should render show all posts page' do
      get :show_all_posts
      response.should render_template('show_all_posts')
    end

    it 'should return an array of post' do
      get :show_all_posts
      assigns(:posts).should be_a(Array)
    end
  end
end
