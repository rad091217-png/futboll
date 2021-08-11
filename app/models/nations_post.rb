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

    def user
      return User.find_by(id: self.user_id)
    end

    def display_image
      image.variant(resize_to_limit: [500, 500])
    end
  end
end
