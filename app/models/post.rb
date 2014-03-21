class Post < ActiveRecord::Base
  belongs_to  :creator, foreign_key: 'user_id', class_name: 'User'
  has_many    :comments
  has_many    :post_categories
  has_many    :categories, through: :post_categories
  has_many    :votes,           as: :votable

  validates :url,         presence: true,
                          uniqueness: true  #REGEX CHECK
  validates :description, presence: true,
                          length: { minimum: 2, maximum: 500}
  validates :title,       presence: true,
                          length: { minimum: 2, maximum: 140 }
  validates :user_id,     presence: true   #HOW DO I SPECIFY THIS ONE USING CREATOR?
  #validates :categories    #HOW DO I VALIDATE THROUGH A JOIN TABLE? Need to verify cats.

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
