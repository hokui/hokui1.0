class AdminController < ApplicationController
  before_filter :admin_authorize

  layout 'admin'

  def index
  end
end
