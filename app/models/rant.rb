class Rant < ActiveRecord::Base
  belongs_to :author, :class_name => User
  has_many :favorites
  has_many :comments, :as => :commentable

  default_scope -> { where(:spam => false) }
  scope :latest_for, ->(user) { where.not(:author => user) }
  scope :mentions_for, ->(user) { where("body like ?", "%@#{user.username}%") }

  validates :title, :body, :presence => true

  validates :title, :length => {:maximum => 50}, :if => -> { title.present? }
  validates :body, :length => {:minimum => 140}, :if => -> { body.present? }

  def favorited_by?(user)
    favorites.find_by(:user => user).present?
  end

  def rendered_body
    Redcarpet::Markdown.new(Redcarpet::Render::HTML)
      .render(hashtagify(body.chomp.strip))
      .html_safe
  end

  def favorite_count
    favorites.count
  end

  def hashtagify(text)
    text.gsub(/\#(\w+)/, '<a href="/search?query=\1">#\1</a>')
  end
end
