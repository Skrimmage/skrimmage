require 'rss'
require 'open-uri'

class LoadTopicsJob < ApplicationJob
  queue_as :default

  def perform(request_id)
    topics = []
    url = 'https://forum.skrimmage.com/latest.rss'
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.first(5).each do |item|
        topics.append(item)
      end
    end
    
    ActionCable.server.broadcast "TopicsChannel:#{request_id}", {
      topics: StaticController.render( partial: 'topics', locals: {topics: topics}).squish
    }
    
  end
end