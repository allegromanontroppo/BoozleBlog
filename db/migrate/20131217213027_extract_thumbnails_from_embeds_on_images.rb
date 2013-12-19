class ExtractThumbnailsFromEmbedsOnImages < ActiveRecord::Migration
  def up
    
    Image.find_each do |image|
      
      next unless image.url?
      
      urls = URI::extract(image.url)
      image.url       = urls.last 
      image.thumbnail = urls.last.gsub(/\/s800\//, '/s332/').gsub(/\/s1024\//, '/s332/')
      image.save
      
    end
    
  end
end
