class Rant < ActiveRecord::Base
  belongs_to :author, :class_name => User

  scope :latest_for, ->(user) { where.not(:author => user) }

  validates :title, :body, :presence => true

  validates :title, :length => {:maximum => 50}, :if => -> { title.present? }
  validates :body, :length => {:minimum => 140}, :if => -> { body.present? }
end
