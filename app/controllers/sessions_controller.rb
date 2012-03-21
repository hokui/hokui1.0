class SessionsController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create]
  layout 'application', except: [:new, :create]
  def new
  end

  def create
    user=User.find_by_mail(params[:mail])
    p user.password_digest, params[:password]
    if user && user.authenticate(params[:password])
      session[:user_id]=user.id
      redirect_to root_url
    else
      flash.now.alert="Invalid mail or password"
      redirect_to action: 'new'
    end
  end

  def destroy
    session[:user_id]=nil
    redirect_to action: 'new', notice: 'Logged out!'
  end
end
