class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  #リサイズ、画像形式を変更に必要
  include CarrierWave::MiniMagick

  #上限変更
  process :resize_to_fit => [700, 700]

  #JPGで保存
  process :convert => "jpg"

  #サムネイルを生成
  version :thumb do
    process :resize_to_fit => [300, 300]
  end

  #ファイル名を変更し拡張子を同じにする
  def filename
    super.chomp(File.extname(super)) + ".jpg"
  end

  #日付で保存
  def filename
    if original_filename.present?
      time = Time.now
      name = time.strftime("%Y%m%d%H%M%S") + ".jpg"
      name.downcase
    end
  end
end
