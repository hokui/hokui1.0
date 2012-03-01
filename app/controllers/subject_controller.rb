class SubjectController < ApplicationController

  layout "subject"

  def index
  end

  def searchData(sub_id)
    @summaries=Summary.where(subject_id: sub_id).select('id, number').order('number ASC')
    @quizzes=Quiz.where(subject_id: sub_id).select('id, number, q_a')
    @exams=Exam.where(subject_id: sub_id).select('id, year, number, q_a')
  end

  def statistics
    @subject=Subject.find_by_page_title("statistics")
    searchData(@subject.id)
  end
end
