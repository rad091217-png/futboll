class AddColumnUserIdToLeaguOnePosts < ActiveRecord::Migration[6.0]
  def change
    add_column :league_one_posts, :user_id, :integer
  end
end
