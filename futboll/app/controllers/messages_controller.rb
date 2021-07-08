class MessagesController < ApplicationController
  before_action :logged_in_user, :only => [:create]

  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(:user_id => current_user.id))
      redirect_to "/rooms/#{@message.room_id}"
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash.now[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end
end
