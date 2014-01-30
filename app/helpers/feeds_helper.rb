module FeedsHelper

  def feed_by_url(feed_url)
    Feed.where({:feed_url => feed_url}).first
  end

  def format_date(date)
    date.strftime("%b %d, %Y %H:%M:%S")
  end

end
