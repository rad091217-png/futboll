class ChampionsPostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy]
  # 投稿一覧
  def index
    @champions_posts = ChampionsPost.paginate(page: params[:page]).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    # @microposts = @user.microposts.paginate(page: params[:page])
    @champions_posts = @user.champions_posts.paginate(page: params[:page])
  end

  def new
    @champions_post = ChampionsPost.new(
      user_id: @current_user.id,
    )
  end

  #投稿内容保存
  def create
    @champions_post = current_user.champions_posts.build(post_params)
    if @champions_post.save
      redirect_to champions_posts_url
      flash[:success] = "投稿に成功しました"
    else
      flash.now[:danger] = "タイトルとコメント両方入力してください"
      render "champions_posts/new"
    end
  end

  def destroy
    @champions_post = ChampionsPost.find(params[:id])
    @champions_post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_back(fallback_location: "champions_post_path(champions_post)")
  end

  private

  def post_params
    params.require(:champions_post).permit(:title, :text, :image, :remove_image)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash.now[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end

  def correct_user
    @user = ChampionsPost.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end
end
