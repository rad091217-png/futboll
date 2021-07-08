class LeagueOnePost < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }
  validates :text, presence: true
  mount_uploader :image, ImageUploader
  belongs_to :user

  def correct_user(current_user)
    if id == current_user.id
      true
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
