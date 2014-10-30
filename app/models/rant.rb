class Rant < ActiveRecord::Base
  belongs_to :author, :class_name => User

  scope :latest_for, ->(user) { where.not(:author => user) }

  validates :title, :body, :presence => true
end
