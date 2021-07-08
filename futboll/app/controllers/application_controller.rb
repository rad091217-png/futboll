class ApplicationController < ActionController::Base
  include SessionsHelper

  def default_url_options
    { locale: I18n.locale }
  end

  private

  # ユーザーのログインを確認する
  def logged_in_user
    unless logged_in?
      store_location
      flash.now[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end
end
