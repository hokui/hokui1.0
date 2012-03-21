class ApplicationController < ActionController::Base
  force_ssl
  before_filter :authorize

  protect_from_forgery

  private

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to controller: 'sessions', action: 'new'
    end
  end

  def admin_authorize
    unless User.find_by_id(session[:user_id]).authority=="admin" or User.find_by_id(session[:user_id]).authority=="system"
      redirect_to controller: 'index', action: 'index', notice: 'you do not have a permission.'
    end
  end

  def system_authorize
    unless User.find_by_id(session[:user_id]).authority=="system"
      redirect_to controller: 'index', action: 'index', notice: 'you do not have a permission.'
    end
  end
end
