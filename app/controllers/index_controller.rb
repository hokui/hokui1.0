class IndexController < ApplicationController
  def index
    if SubjectUpdate.all.blank?
      @subject_update_notice='NO recent updates'
    else
      @subject_updates=SubjectUpdate.limit(5)
    end
  end

  def sns
  end

  def about
  end

end
