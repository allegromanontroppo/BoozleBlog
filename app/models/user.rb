class User < ActiveRecord::Base
  has_many :posts

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

# == Schema Information
#
# Table name: users
#
#  id                      :integer         not null, primary key
#  email                   :string(255)     default(""), not null
#  encrypted_password      :string(128)     default(""), not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer         default(0)
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#  is_super_user           :boolean
#  can_post                :boolean
#  avatar                  :string(255)
#  name                    :string(255)
#  notify_when_new_post    :boolean         default(TRUE)
#  notify_when_new_comment :boolean         default(FALSE)
#

