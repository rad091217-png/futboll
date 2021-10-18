class JupilerPostsController < ApplicationController
  before_action :logged_in_user, except: [:index]
  before_action :correct_user, only: [:destroy]
  # 投稿一覧
  def index
    @jupiler_posts = JupilerPost.paginate(page: params[:page]).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    # @microposts = @user.microposts.paginate(page: params[:page])
    @jupiler_posts = @user.jupiler_posts.paginate(page: params[:page])
  end

  def new
    @jupiler_post = JupilerPost.new(
      user_id: @current_user.id,
    )
  end

  #投稿内容保存
  def create
    @jupiler_post = current_user.jupiler_posts.build(post_params)
    if @jupiler_post.save
      redirect_to jupiler_posts_url
      flash[:success] = "投稿に成功しました"
    else
      flash.now[:danger] = "タイトルとコメント両方入力してください"
      render "jupiler_posts/new"
    end
  end

  def destroy
    @jupiler_post = JupilerPost.find(params[:id])
    @jupiler_post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_back(fallback_location: "jupiler_post_path(jupiler_post)")
  end

  private

  def post_params
    params.require(:jupiler_post).permit(:title, :text, :image, :remove_image)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash.now[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end

  def correct_user
    @user = JupilerPost.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end
end
