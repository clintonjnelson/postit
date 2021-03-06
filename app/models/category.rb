class Category < ActiveRecord::Base
  include SluggableCjn # Includes Callback & Instance Methods & Attr "slug_column"

  sluggable_column :name

  has_many  :post_categories
  has_many  :posts, through: :post_categories


  before_save :capitalize_name
  validates :name, presence: true,
                   length: { minimum: 2, maximum: 20 },
                   uniqueness: true

  private
    def capitalize_name
      self.name = self.name.split.map(&:capitalize).join(' ')
    end
end
