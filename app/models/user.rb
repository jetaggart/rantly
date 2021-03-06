class User < ActiveRecord::Base
  has_secure_password

  mount_uploader :image, ImageUploader

  enum :type_of_ranter => [:daily, :weekly, :monthly]

  has_many :comments, :as => :commentable
  has_many :followings, :foreign_key => "follower_id"
  has_many :following_users, :through => :followings, :source => "following"
  has_many :followers, :foreign_key => "following_id", :class_name => Following
  has_many :rants, :foreign_key => :author_id
  has_many :favorites
  has_many :favorite_rants, :through => :favorites, :source => "rant"

  validates :username, :type_of_ranter, :bio, :first_name, :last_name, :image, :email,
            :presence => true
  validates :username, :uniqueness => true
  validates :password, :length => { :minimum => 8 }, :if => -> { password.present? }

  before_create :set_confirmation_token

  def full_name
    "#{first_name} #{last_name}"
  end

  def followed_by?(other_user)
    followers.any? {|f| f.follower_id == other_user.id }
  end

  def following_for(other_user)
    followings.find_by(:following_id => other_user.id)
  end

  def favorite_for(rant)
    favorites.find_by(:rant => rant)
  end

  def confirmed?
    confirmation_token.nil?
  end

  def set_confirmation_token
    self.confirmation_token = SecureRandom.uuid
  end

  def rants_by_favorites
    rants
      .select("rants.*, COUNT(favorites.id) as favorite_count")
      .joins("LEFT JOIN favorites ON favorites.rant_id = rants.id")
      .group("rants.id")
      .order("favorite_count DESC")
  end
end
