require "carrierwave/storage/abstract"
require "carrierwave/storage/file"
require "carrierwave/storage/fog"

CarrierWave.configure do |config|
  if Rails.env.production? # 本番環境の場合はS3へアップロード
    config.storage :fog
    config.fog_provider = "fog/aws"
    config.fog_directory = "real1210" # バケット名
    config.fog_public = false
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: ENV["AKIAQIYXF7GPKM77D6HH"], # アクセスキー
      aws_secret_access_key: ENV["f1ooUEUIvVbTf2CMJ5aJ1YpVrQ7Abd6hOhpT3P0S"], # シークレットアクセスキー
      region: "ap-northeast-3", # リージョン
      path_style: true,
    }
  else # 本番環境以外の場合はアプリケーション内にアップロード
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end
