class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(token: params[:token])
    now_time = Time.now
    if user && !user.activated? && now_time < user.expired_at
      user.activate
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      login user
      flash.now[:success] = "あなたのアカウントは有効化されました"
      redirect_to user
    else
      flash.now[:danger] = "アカウント有効化に失敗しました"
      redirect_to root_url
    end
  end
end
