class Profile < ApplicationRecord
  # do nothing
  has_one_attached :image

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
