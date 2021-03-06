class NationsPostsController < ApplicationController
  before_action :logged_in_user, except: [:index]
  before_action :correct_user, only: [:destroy]
  # 投稿一覧
  def index
    @nations_posts = NationsPost.paginate(page: params[:page]).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    # @microposts = @user.microposts.paginate(page: params[:page])
    @nations_posts = @user.nations_posts.paginate(page: params[:page])
  end

  def new
    @nations_post = NationsPost.new(
      user_id: @current_user.id,
    )
  end

  #投稿内容保存
  def create
    @nations_post = current_user.nations_posts.build(post_params)
    if @nations_post.save
      redirect_to nations_posts_url
      flash[:success] = "投稿に成功しました"
    else
      flash.now[:danger] = "タイトルとコメント両方入力してください"
      render "nations_posts/new"
    end
  end

  def destroy
    @nations_post = NationsPost.find(params[:id])
    @nations_post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_back(fallback_location: "nations_post_path(nations_post)")
  end

  private

  def post_params
    params.require(:nations_post).permit(:title, :text, :image, :remove_image)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash.now[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end

  def correct_user
    @user = NationsPost.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end
end
