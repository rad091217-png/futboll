class CreateLeagueOnePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :league_one_posts do |t|
      t.string :title
      t.text :text
      t.string :image
      t.timestamps null: true
    end
  end
end
