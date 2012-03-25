class SystemController < ApplicationController
  before_filter :system_authorize

  layout 'system'

  def index
  end
end
