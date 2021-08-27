class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :token
      t.datetime :expired_at, null: false
      t.timestamps

      t.index ["token"], name: "index_temp_users_on_token", unique: true
    end
  end
end
