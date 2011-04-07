xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Microposts"
    xml.description @user.name. + " Microposts"
    
    for micropost in @microposts_all
      xml.item do
        xml.description micropost.content
        
        xml.pubDate micropost.created_at.to_s(:rfc822)
      end
    end
  end
end
