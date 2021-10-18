class BundesuPostsController < ApplicationController
  before_action :logged_in_user, except: [:index]
  before_action :correct_user, only: [:destroy]
  # 投稿一覧
  def index
    @bundesu_posts = BundesuPost.paginate(page: params[:page]).order(created_at: :desc)
  end

  #投稿作成画面
  def show
    @user = User.find(params[:id])
    # @microposts = @user.microposts.paginate(page: params[:page])
    @bundesu_posts = @user.bundesu_posts.paginate(page: params[:page])
  end

  def new
    @bundesu_post = BundesuPost.new(
      user_id: @current_user.id,
    )
  end

  #投稿内容保存
  def create
    @bundesu_post = current_user.bundesu_posts.build(post_params)
    if @bundesu_post.save
      redirect_to bundesu_posts_url
      flash[:success] = "投稿に成功しました"
    else
      flash.now[:danger] = "タイトルとコメント両方入力してください"
      render "bundesu_posts/new"
    end
  end

  def destroy
    @bundesu_post = BundesuPost.find(params[:id])
    @bundesu_post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_back(fallback_location: "bundesu_post_path(bundesu_post)")
  end

  private

  def post_params
    params.require(:bundesu_post).permit(:title, :text, :image, :remove_image)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash.now[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end

  def correct_user
    @user = BundesuPost.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end
end
