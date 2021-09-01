class ScotishPostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy]
  # 投稿一覧
  def index
    @scotish_posts = ScotishPost.paginate(page: params[:page]).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    # @microposts = @user.microposts.paginate(page: params[:page])
    @scotish_posts = @user.scotish_posts.paginate(page: params[:page])
  end

  def new
    @scotish_post = ScotishPost.new(
      user_id: @current_user.id,
    )
  end

  #投稿内容保存
  def create
    @scotish_post = current_user.scotish_posts.build(post_params)
    if @scotish_post.save
      redirect_to scotish_posts_url
      flash[:success] = "投稿に成功しました"
    else
      flash.now[:danger] = "タイトルとコメント両方入力してください"
      render "scotish_posts/new"
    end
  end

  def destroy
    @scotish_post = ScotishPost.find(params[:id])
    @scotish_post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_back(fallback_location: "scotish_post_path(scotish_post)")
  end

  private

  def post_params
    params.require(:scotish_post).permit(:title, :text, :image, :remove_image)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash.now[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end

  def correct_user
    @user = ScotishPost.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end
end
