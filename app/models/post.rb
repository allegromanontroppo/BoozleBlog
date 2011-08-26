class Post < ActiveRecord::Base
  
	belongs_to :user
	has_many :comments, :dependent => :delete_all
	has_many :tags, :dependent => :delete_all 
	has_many :images, :dependent => :delete_all 
	has_many :videos, :dependent => :delete_all 

	validates_presence_of :title
	validates_presence_of :body
	validates_associated :comments
#	validates_associated :tag
	validates_associated :images
	validates_associated :videos
	
	def self.recent(limit = 7, trim_to_odd = true)
	  
	  posts =  all :order => "created_at desc", :limit => limit, :include => [:comments, :user, :tags, :videos, :images]
	  posts.pop if trim_to_odd && posts.length.even?
    posts 

	end
	
	def self.find_by_tag(tag)
	  
	  all :conditions => ["posts.id in (select post_id from tags where tag like ?)", tag], :order => "created_at DESC",  :include => [:comments, :user, :tags]
	
	end
	
	def self.archive
	  
	  posts = all :select => "created_at", :order => "created_at DESC"
	  
	  posts.group_by{|post| post.created_at.beginning_of_month}.map do |grouped_posts| 
        { :month => grouped_posts[0], :posts_count => grouped_posts[1].count }
      end
	  
	end
	
	def self.find_by_month(month)
	  
	  all :conditions => { :created_at => (month)..(month + 1.month) }, :order => "created_at DESC", :include => [:comments, :user, :tags]
	  
	end

	def to_param
		"#{self.id} #{self.title}".parameterize 
	end

	def date_pretty
		self[:created_at].strftime("%A #{self[:created_at].day.ordinalize} %B %Y")
	end
	
	def previous_post
	  if @previous_post.nil?
  	    @previous_post = self.class.first(:conditions => ["created_at < ?", created_at], :order => "created_at desc")
	  end
	  @previous_post
	end

	def next_post
	  if @next_post.nil?
	    @next_post = self.class.first(:conditions => ["created_at > ?", created_at], :order => "created_at asc")
	  end
	  @next_post
	end
	
end
