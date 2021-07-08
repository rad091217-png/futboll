class PremierPostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy]
  # 投稿一覧
  def index
    @premier_posts = PremierPost.paginate(page: params[:page]).order(created_at: :desc)
  end

  #投稿作成画面
  def show
    @premier_post = current_user.premier_posts.build()
  end

  def new
    @premier_post = PremierPost.new
  end

  #投稿内容保存
  def create
    @premier_post = current_user.premier_posts.build(post_params)
    if @premier_post.save
      redirect_to premier_posts_url
      flash[:success] = "投稿に成功しました"
    else
      flash.now[:danger] = "タイトルとコメント両方入力してください"
      render "premier_posts/new"
    end
  end

  def destroy
    @premier_post = PremierPost.find(params[:id])
    @premier_post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_back(fallback_location: "premier_post_path(premier_post)")
  end

  private

  def post_params
    params.require(:premier_post).permit(:title, :text, :image, :remove_image)
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
