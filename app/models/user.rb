class User < ActiveRecord::Base
  has_secure_password

  has_many :followings, :foreign_key => "follower_id"
  has_many :following, :through => :followings

  enum :type_of_ranter => [:daily, :weekly, :monthly]

  has_many :rants, :foreign_key => :author_id
  def full_name
    "#{first_name} #{last_name}"
  end
end
