Welcome to RSS-reader
=====================

Features
-------------
Interface to add/remove/edit Feed URLS.
List all feeds. Fetch RSS feed titles automatically.
A reader page – fetch latest posts from all feeds and combine them together. Sort by date – most recent first and then
display. Display title only. Clicking on title will open original article page in new tab.

By default we are fetching latest 10 posts of each feed. You can customize it by passing second parameter in following RSS reader function-
fetch_all_feeds_posts(feed_urls, entries_counter = 10)

Feedzirra
--------------
We have used Feedzirra to fetch and parse the feed URLS. You can get more info: https://github.com/pauldix/feedzirra
Feedzirra is a feed library that is designed to get and update many feeds as quickly as possible. This includes using libcurl-multi through the curb gem for faster http gets, and libxml through nokogiri and sax-machine for faster parsing. Feedzirra requires at least Ruby 1.9.2.

Development Tools
---------------
Ruby 1.9.2
Rails 3.2.11
Mysql

You can use sample feed URLs
-----------------------------
"http://feeds.feedburner.com/PaulDixExplainsNothing", "http://feeds.feedburner.com/trottercashion"

