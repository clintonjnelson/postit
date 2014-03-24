class Comment < ActiveRecord::Base
  include VotableClintMarch  # Includes Association & Instance Methods

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :body,    presence: true,
                      length:   { maximum: 300 }
end
