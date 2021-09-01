class SeriePostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy]
  # 投稿一覧
  def index
    @serie_posts = SeriePost.paginate(page: params[:page]).order(created_at: :desc)
  end

  #投稿作成画面
  def show
    @user = User.find(params[:id])
    # @microposts = @user.microposts.paginate(page: params[:page])
    @serie_posts = @user.serie_posts.paginate(page: params[:page])
  end

  def new
    @serie_post = SeriePost.new(
      user_id: @current_user.id,
    )
  end

  #投稿内容保存
  def create
    @serie_post = current_user.serie_posts.build(post_params)
    if @serie_post.save
      redirect_to serie_posts_url
      flash[:success] = "投稿に成功しました"
    else
      flash.now[:danger] = "タイトルとコメント両方入力してください"
      render "serie_posts/new"
    end
  end

  def destroy
    @serie_post = SeriePost.find(params[:id])
    @serie_post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_back(fallback_location: "serie_post_path(serie_post)")
  end

  private

  def post_params
    params.require(:serie_post).permit(:title, :text, :image, :remove_image)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash.now[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end

  def correct_user
    @user = SeriePost.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end
end
