class SessionsController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create]
  layout 'application', except: [:new, :create]
  def new
  end

  def create
    if User.find_by_mail(params[:mail]).blank?
      redirect_to action: 'new', notice: 'invalid email'
    else
      user=User.find_by_mail(params[:mail])
    end
    if user.authenticate(params[:password])
      session[:user_id]=user.id
      if user.full_name.blank? or user.handle_name.blank?
        redirect_to '/profile', notice: 'Please input user information'
      else
        redirect_to root_url
      end
    else
      redirect_to action: 'new', notice: 'invalid password'
    end
  end

  def destroy
    session[:user_id]=nil
    redirect_to action: 'new', notice: 'Logged out!'
  end
end
