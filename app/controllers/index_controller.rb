class IndexController < ApplicationController
  def index
    @subject_updates=SubjectUpdate.limit(5)
    if @subject_updates.blank?
      @subject_update_notice='NO recent updates'
    end
  end

  def sns
  end

  def about
  end

end
