class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :rant

  validates :user, :rant, :presence => true
end
