class SubjectController < ApplicationController

  layout "subject"

  def index
  end

  def searchData
    @summaries=Summary.where(subject_id: @subject.id).select('id, number').order('number ASC')
    @quizzes=Quiz.where(subject_id: @subject.id).select('id, number, q_a')
    @exams=Exam.where(subject_id: @subject.id).select('id, year, number, q_a')
    @bbs_topic=BbsTopic.find(@subject.bbs_topic.id)
    @bbs_body=BbsBody.new
  end

  def statistics
    @subject=Subject.find_by_page_title("statistics")
    searchData
  end
end
