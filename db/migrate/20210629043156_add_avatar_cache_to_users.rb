class AddAvatarCacheToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :avatar_cache, :string
  end
end
