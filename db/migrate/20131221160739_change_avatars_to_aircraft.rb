class ChangeAvatarsToAircraft < ActiveRecord::Migration
  def up
    
    matrix = {
      'dad' => 'tornado.jpg',
      'mum' => 'typhoon.jpg',
      'hollands' => 'lancaster.jpg',
      'jacksons' => 'spitfire.jpg'
    }
    
    User.find_each do |u|
      
      if matrix.keys.include? u.name.downcase
        u.update_attribute :avatar, matrix[u.name.downcase]
      end
      
    end
    
  end

  def down
  end
end
