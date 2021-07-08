class HomeController < ApplicationController
  def top
  end

  def liga
    if logged_in?
      # do nothing
    else
      flash.now[:danger] = "ログインしてください"
    end
  end

  def bundesu
    if logged_in?
      # do nothing
    else
      flash.now[:danger] = "ログインしてください"
    end
  end

  def premier
    if logged_in?
      # do nothing
    else
      flash.now[:danger] = "ログインしてください"
    end
  end

  def serie
    if logged_in?
      # do nothing
    else
      flash.now[:danger] = "ログインしてください"
    end
  end

  def league_one
    if logged_in?
      # do nothing
    else
      flash.now[:danger] = "ログインしてください"
    end
  end

  def premera
    if logged_in?
      # do nothing
    else
      flash.now[:danger] = "ログインしてください"
    end
  end

  def euro
    if logged_in?
      # do nothing
    else
      flash.now[:danger] = "ログインしてください"
    end
  end

  def nations_league
    if logged_in?
      # do nothing
    else
      flash.now[:danger] = "ログインしてください"
    end
  end

  def help
  end
end
