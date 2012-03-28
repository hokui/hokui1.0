class ProfileController < ApplicationController
  layout 'application'

  def edit_profile
    @user=User.find(session[:user_id])
  end

  def update_profile
  end

  def edit_password
  end

  def update_password
    user=User.find(session[:user_id])
  end
end
