class PremierPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :premier_posts, :user_id, :integer
  end
end
