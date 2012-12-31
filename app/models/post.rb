class Post < ActiveRecord::Base
  
	belongs_to :user
	has_many :comments, :dependent => :destroy
	has_many :tags,     :dependent => :destroy 
	has_many :photos,   :dependent => :destroy, :class_name => 'Image'
	has_many :videos,   :dependent => :destroy 
	
	validates :title, :presence => true
	
	accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => lambda { |i| i[:embed].blank? }
	accepts_nested_attributes_for :videos, :allow_destroy => true, :reject_if => lambda { |v| v[:embed].blank? }
	
	default_scope order('created_at desc')
	
	def self.find_by_tag(tag)
	  posts = where('id in (select post_id from tags where tag like ?)', tag).order('id DESC').includes(:comments, :tags)
	end
	
	def self.archives
	  
	  posts = select('created_at').order('id DESC')
	  
    archive = []

	  year_count = posts.group_by{ |post| post.created_at.beginning_of_year }.map do |year| 
	    
      months = posts.select{ |p| p.created_at.beginning_of_year ==  year[0] }.group_by{ |p| p.created_at.beginning_of_month }.map do |month| 
        { :month => month[0], :count => month[1].count }
      end

      archive << { 
        :year => year[0], 
        :count => year[1].count, 
        :months => months.sort_by{ |m| m[:month] }.reverse
      }      
      
    end
    
    archive.sort_by{ |a| a[:year] }.reverse
    
	end
	
	def self.find_by_year(year)
	  where(:created_at => (year)..(year + 1.year)).order('created_at').includes(:comments, :user, :tags)
	end
	
	def self.find_by_month(month)
  	where(:created_at => (month)..(month + 1.month)).order('created_at').includes(:comments, :user, :tags)
	end

	def to_param
		"#{self.id} #{self.title}".parameterize 
	end

	def date_pretty
		self.created_at.strftime("%A #{self[:created_at].day.ordinalize} %B %Y")
	end
	
	def previous_post
	  @previous_post ||= self.class.where("created_at < ?", created_at).order("created_at desc").first
	end

	def next_post
	  @next_post ||= self.class.where("created_at > ?", created_at).order("created_at asc").first
	end
		
	def allowed_to_edit_or_delete?(current_user)
	  current_user.nil? ? false : (current_user.is_super_user || current_user.id == self.user_id )
	end
	
end

# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  title      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

