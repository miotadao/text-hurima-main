class Post < ApplicationRecord
  
  belongs_to :user
  has_one_attached :image
  belongs_to :bought_user, class_name: 'User', foreign_key: 'bought_id', optional: true
  has_many :talks, dependent: :destroy

#検索機能

   # `title`での検索
   scope :search_by_title, -> (query) {
    where("LOWER(title) LIKE ?", "%#{query.downcase}%")
  }

  # `author`での検索
  scope :search_by_author, -> (query) {
    where("LOWER(author) LIKE ?", "%#{query.downcase}%")
  }

  scope :not_received, -> { where(is_receive: false) }
  
end
