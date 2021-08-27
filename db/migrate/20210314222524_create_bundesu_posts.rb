class CreateBundesuPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :bundesu_posts do |t|
      t.string :title
      t.text :text
      t.string :image
      t.timestamps null: true
    end
  end
end
