class BbsController < ApplicationController

  layout 'bbs'

  def index
    @bbs_body=BbsBody.new
  end

end
