# -*- encoding:utf-8 -*-

class ProfileController < ApplicationController

  layout 'application'

  def edit_profile
    @user=User.find(session[:user_id])
  end

  def update_profile
    user=User.find(session[:user_id])
    user.full_name=params[:full_name].split('　').join.split.join
    user.handle_name=params[:handle_name]
    year='%04d' % params[:birthday][:year].to_i
    month='%02d' % params[:birthday][:month].to_i
    day='%02d' % params[:birthday][:day].to_i
    user.birthday="#{year}-#{month}-#{day}"
    user.mail=params[:mail]
    user.save
    redirect_to '/'
  end

  def edit_password
  end

  def update_password
    if params[:new_password]!=params[:new_password_confirm] or params[:new_password].blank?
      redirect_to action: 'change_password'
      return
    end

    user=User.find(session[:user_id])
    if user.authenticate(params[:password])
      user.password=params[:new_password]
      user.save
      redirect_to '/profile/edit_profile'
    else
      redirect_to action: 'change_password'
    end
  end
end
