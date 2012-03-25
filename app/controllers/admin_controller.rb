class AdminController < ApplicationController
  before_filter :admin_authorize, only: :index
  before_filter :system_authorize, only: :system

  def index
    render layout: 'admin'
  end

  def system
    render layout: 'system'
  end
end
