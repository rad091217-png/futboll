class LaligaPostsController < ApplicationController
  before_action :logged_in_user, except: [:index]
  before_action :correct_user, only: [:destroy]
  # 投稿一覧
  def index
    @laliga_posts = LaligaPost.paginate(page: params[:page]).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    # @microposts = @user.microposts.paginate(page: params[:page])
    @laliga_posts = @user.laliga_posts.paginate(page: params[:page])
  end

  def new
    @laliga_post = LaligaPost.new(
      user_id: @current_user.id,
    )
  end

  #投稿内容保存
  def create
    @laliga_post = current_user.laliga_posts.build(post_params)
    if @laliga_post.save
      redirect_to laliga_posts_url
      flash[:success] = "投稿に成功しました"
    else
      flash.now[:danger] = "タイトルとコメント両方入力してください"
      render "laliga_posts/new"
    end
  end

  def destroy
    @laliga_post = LaligaPost.find(params[:id])
    @laliga_post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_back(fallback_location: "laliga_post_path(laliga_post)")
  end

  private

  def post_params
    params.require(:laliga_post).permit(:title, :text, :image, :remove_image)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash.now[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end

  def correct_user
    @user = LaligaPost.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end
end
