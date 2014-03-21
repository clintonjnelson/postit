class Comment < ActiveRecord::Base
  include SharedMethods

  has_many   :votes,            as: :votable
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :body,    presence: true,
                      length:   { maximum: 300 }

    #NEED TO DRY THIS OUT --- IT'S IN COMMENTS & APPLICATION HELPER, TOO
  def upvotes_count
    self.votes.where(vote: true).size
  end

  def downvotes_count
    self.votes.where(vote: false).size
  end

  def net_votes
    self.upvotes_count - self.downvotes_count
  end
end
