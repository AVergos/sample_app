xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Micropost Feeds"
    xml.description "Your Feeds"
    
    for feeds in @feed_items_all
      xml.item do
        xml.description feeds.content        
        xml.pubDate feeds.created_at.to_s(:rfc822)
      end
    end
  end
end
