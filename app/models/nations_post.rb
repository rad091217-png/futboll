class NationsPost < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }
  validates :text, presence: true
  has_one_attached :image
  belongs_to :user

  def correct_user(current_user)
    if id == current_user.id
      true
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
