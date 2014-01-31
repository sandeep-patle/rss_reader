module FeedReader

  # Validates Feed URL
  # Fetch and parse single feed by passing feed URL
  # Checking error and feed title for validation
  # Normal url(like google.com etc) also giving response so added begin rescue for this case
  def is_valid_feed_url?(feed_url)
    begin
      title, error_message = "", ""
      feed = Feedzirra::Feed.fetch_and_parse(feed_url, :on_success => lambda {|url, feed_obj| title = feed_obj.title }, :on_failure => lambda {|curl, error| error_message = error })
      Rails.logger.debug(error_message)
      error_message.blank? && !title.blank?
    rescue
      false
    end
  end

  # Fetch and parse all feed by passing feed URLS array
  # Getting feed entries(posts) for each feed
  def fetch_all_feeds(feed_urls)
    feed_collections = Feedzirra::Feed.fetch_and_parse(feed_urls)
    feed_collections.values
  end

  # Sorting posts by published date in descending order
  def sort_by_date(posts)
    posts.sort { |p1, p2| p2.published <=> p1.published }
  end

  # Taking latest 10 posts from each feed and combining as per published order
  def fetch_all_feeds_posts(feed_urls, entries_counter = 10 )
    feeds = fetch_all_feeds(feed_urls)
    posts = []
    feeds.each do |feed|
      posts << sort_by_date(feed.entries).first(entries_counter)
    end
    sort_by_date(posts.flatten)
  end
end