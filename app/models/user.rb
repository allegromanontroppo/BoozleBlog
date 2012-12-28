class User < ActiveRecord::Base
  has_many :posts, :order => 'id desc'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable 
  devise :database_authenticatable, # :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :notify_when_new_post, :notify_when_new_comment


  def to_param
		"#{self.id} #{self.name}".parameterize 
  end

  def email_with_name
     "#{self.name} <#{self.email}>"
  end

end


