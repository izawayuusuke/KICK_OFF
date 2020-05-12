require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KICKOff
  class Application < Rails::Application
    #言語ファイルを階層ごとに設定する
    I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    # アプリケーションが対応している言語のホワイトリスト
    I18n.config.available_locales = %i(ja en)

    # 上記の対応言語以外の言語が指定された場合、エラーとするか
    I18n.enforce_available_locales = true

    # デフォルト言語を日本語に設定
    I18n.default_locale = :ja
    config.time_zone = "Tokyo"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
