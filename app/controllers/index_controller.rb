class IndexController < ApplicationController
  def index
    if session[:user_id].blank?
      redirect_to controller: 'users', action: 'login'
    end
  end

  def sns
  end

  def about
  end

end
