class AddIndexToPosts < ActiveRecord::Migration
  def change
      # Add column for foreign_key index
      # Add foreign_key index to the posts table called user_id to point to Users
      # Created_at may also be an index for ordering of posts by newest-first
      add_column :posts, :user_id, :integer
      add_index :posts, :user_id
  end
end
