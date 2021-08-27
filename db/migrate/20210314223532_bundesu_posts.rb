class BundesuPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :bundesu_posts, :user_id, :integer
  end
end
