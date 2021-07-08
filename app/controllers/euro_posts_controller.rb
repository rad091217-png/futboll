class EuroPostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy]
  # 投稿一覧
  def index
    @euro_posts = EuroPost.paginate(page: params[:page]).order(created_at: :desc)
  end

  #投稿作成画面
  def show
    @euro_post = current_user.euro_posts.build()
  end

  def new
    @euro_post = EuroPost.new
  end

  #投稿内容保存
  def create
    @euro_post = current_user.euro_posts.build(post_params)
    if @euro_post.save
      redirect_to euro_posts_url
      flash[:success] = "投稿に成功しました"
    else
      flash.now[:danger] = "タイトルとコメント両方入力してください"
      render "euro_posts/new"
    end
  end

  def destroy
    @euro_post = EuroPost.find(params[:id])
    @euro_post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_back(fallback_location: "euro_post/index")
  end

  private

  def post_params
    params.require(:euro_post).permit(:title, :text, :image, :remove_image)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash.now[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
