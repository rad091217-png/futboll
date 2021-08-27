class CreateLaligaPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :laliga_posts do |t|
      t.string :title
      t.text :text
      t.string :image
      t.timestamps null: true
    end
  end
end
