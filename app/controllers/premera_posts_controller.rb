class PremeraPostsController < ApplicationController
  before_action :logged_in_user, except: [:index]
  before_action :correct_user, only: [:destroy]
  # 投稿一覧
  def index
    @premera_posts = PremeraPost.paginate(page: params[:page]).order(created_at: :desc)
  end

  #投稿作成画面
  def show
    @user = User.find(params[:id])
    # @microposts = @user.microposts.paginate(page: params[:page])
    @premera_posts = @user.premera_posts.paginate(page: params[:page])
  end

  def new
    @premera_post = PremeraPost.new(
      user_id: @current_user.id,
    )
  end

  #投稿内容保存
  def create
    @premera_post = current_user.premera_posts.build(post_params)
    if @premera_post.save
      redirect_to premera_posts_url
      flash[:success] = "投稿に成功しました"
    else
      flash.now[:danger] = "タイトルとコメント両方入力してください"
      render "premera_posts/new"
    end
  end

  def destroy
    @premera_post = PremeraPost.find(params[:id])
    @premera_post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_back(fallback_location: "premera_post_path(premera_post)")
  end

  private

  def post_params
    params.require(:premera_post).permit(:title, :text, :image, :remove_image)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash.now[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end

  def correct_user
    @user = PremeraPost.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end
end
