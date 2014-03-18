class Post < ActiveRecord::Base
  belongs_to  :creator, foreign_key: 'user_id', class_name: 'User'
  has_many    :comments
  has_many    :post_categories
  has_many    :categories, through: :post_categories

  validates :url,         presence: true,
                          uniqueness: true  #REGEX CHECK
  validates :description, presence: true,
                          length: { minimum: 2, maximum: 500}
  validates :title,       presence: true,
                          length: { minimum: 2, maximum: 140 }
  #validates :creator, presence: true   #HOW DO I SPECIFY THIS ONE USING CREATOR?
  #validates :categories    #HOW DO I VALIDATE THROUGH A JOIN TABLE? Need to verify cats.
end
