class Comment < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post

  #validates :user_id, presence: true
  validates :post_id, presence: true
  validates :body,    presence: true,
                      length:   { maximum: 300 }

end
