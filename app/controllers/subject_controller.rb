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
    @subject_id=params[:id]
  end

  def edit_exam
    @exam=Exam.find(params[:id])
  end

  def create_exam
    exam=Exam.new
    exam.subject_id=params[:subject_id]
    exam.year=params[:date][:year]
    exam.number=params[:number]
    exam.q_a=params[:q_a]
    exam.file=params[:file].read
    exam.content_type=params[:file].content_type
    ext=check_content_type(exam.content_type)
    if ext==nil
      redirect_to 'new_exam', notice: 'invalid file type'
    end
    exam.file_name="#{Subject.find(exam.subject_id).title_en}-past_exam-"+
                   "#{exam.year}-#{exam.number}-#{exam.q_a}.#{ext}"
    exam.uploaded_by=session[:user_id]
    exam.deleted=0
    exam.save
    redirect_to action: 'subject', id: params[:subject_id]
  end

  def update_exam
  end

  def new_quiz
    @subject_id=params[:id]
  end

  def edit_quiz
    @quiz=Quiz.find(params[:id])
  end

  def create_quiz
    quiz=Quiz.new
    quiz.subject_id=params[:subject_id]
    quiz.number=params[:number]
    quiz.q_a=params[:q_a]
    quiz.file=params[:file].read
    quiz.content_type=params[:file].content_type
    ext=check_content_type(quiz.content_type)
    if ext==nil
      redirect_to 'new_quiz', notice: 'invalid file type'
    end
    quiz.file_name="#{Subject.find(quiz.subject_id).title_en}-past_quiz-"+
                   "#{quiz.number}-#{quiz.q_a}.#{ext}"
    quiz.uploaded_by=session[:user_id]
    quiz.deleted=0
    quiz.save
    redirect_to action: 'subject', id: params[:subject_id]
  end

  def update_quiz
  end

  def new_summary
    @subject_id=params[:id]
  end

  def edit_summary
    @summary=Summary.find(params[:id])
  end

  def create_summary
    summary=Summary.new
    summary.subject_id=params[:subject_id]
    summary.number=params[:number]
    summary.file=params[:file].read
    summary.content_type=params[:file].content_type
    ext=check_content_type(summary.content_type)
    if ext==nil
      redirect_to 'new_summary', notice: 'invalid file type'
    end
    summary.file_name="#{Subject.find(summary.subject_id).title_en}-summary-#{summary.number}.#{ext}"
    summary.uploaded_by=session[:user_id]
    summary.deleted=0
    summary.save
    redirect_to action: 'subject', id: params[:subject_id]
  end

  def update_summary
  end

  def check_content_type(content_type)
    case content_type
    when 'application/pdf'
      return 'pdf'
    when 'image/jpeg'
      return 'jpg'
    when 'image/png'
      return 'png'
    when 'image/gif'
      return 'gif'
    when 'image/tiff'
      return 'tif'
    when 'application/msword'
      return 'doc'
    when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      return 'docx'
    when 'application/vnd.ms-powerpoint'
      return 'ppt'
    when 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
      return 'pptx'
    when 'text/plain'
      return 'txt'
    when 'text/rtf'
      return 'rtf'
    when 'application/rtf'
      return 'rtf'
    else
      return nil
    end
  end
end
