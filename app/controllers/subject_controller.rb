class SubjectController < ApplicationController

  layout "subject"

  def index
  end

  def subject
    @subject=Subject.find(params[:id])
    if Summary.where(subject_id: @subject.id, deleted: 0).blank?
      @notice_summary='NO summary files exist.'
    else
      @summaries=Summary.where(subject_id: @subject.id, deleted: 0).select('id, number').order('number ASC')
    end
    if Quiz.where(subject_id: @subject.id, deleted: 0).blank?
      @notice_quiz='NO quiz files exist.'
    else
      @quizzes=Quiz.where(subject_id: @subject.id, deleted: 0).select('id, number, q_a').order('number ASC, q_a DESC')
    end
    if Exam.where(subject_id: @subject.id, deleted: 0).blank?
      @notice_exam='NO exam files exist.'
    else
      @exams=Exam.where(subject_id: @subject.id, deleted: 0).select('id, year, number, q_a').order('year ASC, number ASC, q_a DESC')
    end
    @bbs_topic=BbsTopic.find(@subject.bbs_topic.id)
    @bbs_body=BbsBody.new
    session[:subject_id]=@subject.id
  end

  def new_exam
  end

  def edit_exam
    @exam=Exam.find(params[:id])
  end

  def create_exam
  end

  def update_exam
  end

  def new_quiz
  end

  def edit_quiz
    @quiz=Quiz.find(params[:id])
  end

  def create_quiz
  end

  def update_quiz
  end

  def new_summary
  end

  def edit_summary
    @summary=Summary.find(params[:id])
  end

  def create_summary
  end

  def update_summary
  end
end
