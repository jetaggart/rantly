class User < ActiveRecord::Base
  has_secure_password

  enum :type_of_ranter => [:daily, :weekly, :monthly]

  has_many :followings, :foreign_key => "follower_id"
  has_many :following_users, :through => :followings, :source => "following"
  has_many :followers, :foreign_key => "following_id", :class_name => Following
  has_many :rants, :foreign_key => :author_id

  validates :username, :type_of_ranter, :bio, :first_name, :last_name,
            :presence => true
  validates :username, :uniqueness => true
  validates :password, :length => { :minimum => 8 }, :if => -> { password.present? }

  def full_name
    "#{first_name} #{last_name}"
  end

  def followed_by?(other_user)
    followers.any? {|f| f.follower_id == other_user.id }
  end

  def following_for(other_user)
    followings.find_by(:following_id => other_user.id)
  end
end
