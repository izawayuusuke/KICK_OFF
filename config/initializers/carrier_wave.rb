require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_directory = ENV['S3_BUCKET']
    config.fog_public = false
    config.fog_provider = 'fog/aws'
    config.cache_storage = :fog
    config.storage :fog
    config.fog_credentials = {
      # Amazon S3用の設定
      provider: 'AWS',
      region: ENV['S3_REGION'],
      aws_access_key_id: ENV['S3_ACCESS_KEY'],
      aws_secret_access_key: ENV['S3_SECRET_KEY'],
      path_style: true
    }
  end
end
