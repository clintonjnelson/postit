class Vote < ActiveRecord::Base
  #NOTE: Don't specify specific items it belongs_to, the votable_type does that
  belongs_to  :votable, polymorphic: true
  belongs_to  :creator, foreign_key: 'user_id', class_name: 'User'

validates_uniqueness_of :creator, scope: [:votable_id, :votable_type]

end
