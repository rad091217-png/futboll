class LaligaPost < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }
  validates :text, presence: true
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :laliga_post_likes
  has_many :liked_users, through: :laliga_post_likes, source: :user

  def correct_user(current_user)
    if id == current_user.id
      true
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def user
    return User.find_by(id: self.user_id)
  end
end
