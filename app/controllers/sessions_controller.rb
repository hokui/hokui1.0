class SessionsController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create]
  def new
  end

  def create
    user=User.find_by_mail(params[:mail])
    if user==nil
      # TODO BUG 条件分岐は読まれてるけど、なぜかredirect先に飛ばない
      redirect_to controller: 'sessions', action: 'new'
    end
    if user.authenticate(params[:password])
      session[:user_id]=user.id
      if user.full_name.blank? or user.handle_name.blank?
        redirect_to '/profile', notice: 'Please input user information'
      else
        redirect_to root_url
      end
    else
      redirect_to action: 'new', notice: 'invalid email or password'
    end
  end

  def destroy
    session[:user_id]=nil
    redirect_to action: 'new', notice: 'Logged out!'
  end
end
