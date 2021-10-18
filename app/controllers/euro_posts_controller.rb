class EuroPostsController < ApplicationController
  before_action :logged_in_user, except: [:index]
  before_action :correct_user, only: [:destroy]
  # 投稿一覧
  def index
    @euro_posts = EuroPost.paginate(page: params[:page]).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    # @microposts = @user.microposts.paginate(page: params[:page])
    @euro_posts = @user.euro_posts.paginate(page: params[:page])
  end

  def new
    @euro_post = EuroPost.new(
      user_id: @current_user.id,
    )
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
    redirect_back(fallback_location: "euro_post_path(euro_post)")
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
    @user = EuroPost.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end
end
