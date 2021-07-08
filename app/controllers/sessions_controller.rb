class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    # ユーザーがデータベースにあり、認証に成功
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        login @user
        params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        message = "アカウントが有効化されませんでした。"
        message += "入力したメールアドレスを確認してみてください"
        flash.now[:danger] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "ログインに失敗しました"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
    flash.now[:success] = "ログアウトしました"
  end
end
