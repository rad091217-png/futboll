class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
    logger.debug("[debug] users#index")
    logger.info("[info] users#index")
    logger.warn("[warn] users#index")
    logger.error("[error] users#index")
    logger.fatal("[fatal] users#index")
  end

  def signup
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    # @microposts = @user.microposts.paginate(page: params[:page])
    @laliga_posts = LaligaPost.paginate(page: params[:page])
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def create
    @user = User.new
    @user = @user.create_temp_user(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_later
      redirect_to root_url
    else
      render "signup"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash.now[:success] = "更新されました"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash.now[:success] = "ユーザーを消去しました"
    redirect_to users_url
  end

  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render "show_follow"
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :avatar_cache)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
