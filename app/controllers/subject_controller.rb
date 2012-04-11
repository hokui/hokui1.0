# -*- encoding: utf-8 -*-

class SubjectController < ApplicationController

  layout "subject"

  def index
  end

  def subject
    @subject=Subject.find(params[:id])
    if @subject.textbooks.blank?
      @textbooks=['NO textbooks infomation are registered']
    else
      @textbooks=@subject.textbooks.split
    end
    if Summary.where(subject_id: @subject.id, deleted: 0).blank?
      @notice_summary='NO summary files exist.'
    else
      @summaries=Summary.where(subject_id: @subject.id, deleted: 0).select('id, number, page, description').order('number ASC')
    end
    if Quiz.where(subject_id: @subject.id, deleted: 0).blank?
      @notice_quiz='NO quiz files exist.'
    else
      @quizzes=Quiz.where(subject_id: @subject.id, deleted: 0).select('id, number, q_a, page, description').order('number ASC, q_a DESC')
    end
    if Exam.where(subject_id: @subject.id, deleted: 0).blank?
      @notice_exam='NO exam files exist.'
    else
      @exams=Exam.where(subject_id: @subject.id, deleted: 0).select('id, year, number, q_a, page, description').order('year ASC, number ASC, q_a DESC')
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
    if Exam.where(subject_id: params[:subject_id], year: params[:date][:year], number: params[:number], q_a: params[:q_a], deleted: 0).blank?
      page=0
    else
      page=Exam.where(subject_id: params[:subject_id], year: params[:date][:year], number: params[:number], q_a: params[:q_a], deleted: 0).maximum('page')
    end
    exam=Exam.new
    exam.subject_id=params[:subject_id]
    exam.year=params[:date][:year]
    exam.number=params[:number]
    exam.q_a=params[:q_a]
    exam.page=page+1
    exam.content_type=params[:file].content_type
    ext=check_content_type(exam.content_type)
    if ext==nil
      redirect_to action: 'new_exam', notice: 'invalid file type'
      return
    end
    exam.file_name="#{Subject.find(exam.subject_id).title_en}-past_exam-"+
                   "#{exam.year}-#{exam.number}-#{exam.q_a}-#{exam.page}.#{ext}"
    exam.uploaded_by=session[:user_id]
    exam.deleted=0
    exam.description=params[:description]
    exam.save

    File.open(RAILS_ROOT+'/public/files/' + exam.file_name, 'wb') do |f|
      f.write(params[:file].read)
    end

    update=SubjectUpdate.new
    update.user_id=session[:user_id]
    update.subject_id=params[:subject_id]
    update.type='up'
    update.data_type='過去問'
    update.file_id=exam.id

    redirect_to action: 'subject', id: params[:subject_id]
  end

  def update_exam
    if Exam.where(subject_id: params[:subject_id], year: params[:date][:year], number: params[:number], q_a: params[:q_a], deleted: 0).blank?
      page=0
    else
      page=Exam.where(subject_id: params[:subject_id], year: params[:date][:year], number: params[:number], q_a: params[:q_a], deleted: 0).maximum('page')
    end
    exam=Exam.find(params[:id])
    old_file_name=exam.file_name
    exam.subject_id=params[:subject_id]
    exam.year=params[:date][:year]
    exam.number=params[:number]
    exam.q_a=params[:q_a]
    exam.page=page+1
    ext=check_content_type(exam.content_type)
    exam.file_name="#{Subject.find(exam.subject_id).title_en}-past_exam-"+
                   "#{exam.year}-#{exam.number}-#{exam.q_a}-#{exam.page}.#{ext}"
    exam.description=params[:description]
    exam.save

    File.rename(RAILS_ROOT+'/public/files/' + old_file_name, RAILS_ROOT+'/public/files/' + exam.file_name)

    update=SubjectUpdate.new
    update.user_id=session[:user_id]
    update.subject_id=params[:subject_id]
    update.type='更新'
    update.data_type='過去問'

    redirect_to action: 'subject', id: params[:subject_id]
  end

  def new_quiz
    @subject_id=params[:id]
  end

  def edit_quiz
    @quiz=Quiz.find(params[:id])
  end

  def create_quiz
    if Quiz.where(subject_id: params[:subject_id], number: params[:number], q_a: params[:q_a], deleted: 0).blank?
      page=0
    else
      page=Quiz.where(subject_id: params[:subject_id], number: params[:number], q_a: params[:q_a], deleted: 0).maximum('page')
    end
    quiz=Quiz.new
    quiz.subject_id=params[:subject_id]
    quiz.number=params[:number]
    quiz.q_a=params[:q_a]
    quiz.page=page+1
    quiz.content_type=params[:file].content_type
    ext=check_content_type(quiz.content_type)
    if ext==nil
      redirect_to action: 'new_quiz', notice: 'invalid file type'
      return
    end
    quiz.file_name="#{Subject.find(quiz.subject_id).title_en}-quiz-"+
                   "#{quiz.number}-#{quiz.q_a}-#{quiz.page}.#{ext}"
    quiz.uploaded_by=session[:user_id]
    quiz.deleted=0
    quiz.description=params[:description]
    quiz.save

    File.open(RAILS_ROOT+'/public/files/' + quiz.file_name, 'wb') do |f|
      f.write(params[:file].read)
    end

    update=SubjectUpdate.new
    update.user_id=session[:user_id]
    update.subject_id=params[:subject_id]
    update.type='up'
    update.data_type='小テスト'
    update.file_id=quiz.id

    redirect_to action: 'subject', id: params[:subject_id]
  end

  def update_quiz
    if Quiz.where(subject_id: params[:subject_id], number: params[:number], q_a: params[:q_a], deleted: 0).blank?
      page=0
    else
      page=Quiz.where(subject_id: params[:subject_id], number: params[:number], q_a: params[:q_a], deleted: 0).maximum('page')
    end
    quiz=Quiz.find(params[:id])
    old_file_name=quiz.file_name
    quiz.subject_id=params[:subject_id]
    quiz.number=params[:number]
    quiz.q_a=params[:q_a]
    quiz.page=page+1
    ext=check_content_type(quiz.content_type)
    quiz.file_name="#{Subject.find(quiz.subject_id).title_en}-quiz-"+
                   "#{quiz.number}-#{quiz.q_a}-#{quiz.page}.#{ext}"
    quiz.description=params[:description]
    quiz.save

    File.rename(RAILS_ROOT+'/public/files/' + old_file_name, RAILS_ROOT+'/public/files/' + quiz.file_name)

    update=SubjectUpdate.new
    update.user_id=session[:user_id]
    update.subject_id=params[:subject_id]
    update.type='更新'
    update.data_type='小テスト'

    redirect_to action: 'subject', id: params[:subject_id]
  end

  def new_summary
    @subject_id=params[:id]
  end

  def edit_summary
    @summary=Summary.find(params[:id])
  end

  def create_summary
    if Summary.where(subject_id: params[:subject_id], number: params[:number], deleted: 0).blank?
      page=0
    else
      page=Summary.where(subject_id: params[:subject_id], number: params[:number], deleted: 0).maximum('page')
    end
    summary=Summary.new
    summary.subject_id=params[:subject_id]
    summary.number=params[:number]
    summary.page=page+1
    summary.content_type=params[:file].content_type
    ext=check_content_type(summary.content_type)
    if ext==nil
      redirect_to action: 'new_summary', notice: 'invalid file type'
      return
    end
    summary.file_name="#{Subject.find(summary.subject_id).title_en}-summary-#{summary.number}-#{summary.page}.#{ext}"
    summary.uploaded_by=session[:user_id]
    summary.deleted=0
    summary.description=params[:description]
    summary.save

    File.open(RAILS_ROOT+'/public/files/' + summary.file_name, 'wb') do |f|
      f.write(params[:file].read)
    end

    update=SubjectUpdate.new
    update.user_id=session[:user_id]
    update.subject_id=params[:subject_id]
    update.type='up'
    update.data_type='授業資料'
    update.file_id=summary.id

    redirect_to action: 'subject', id: params[:subject_id]
  end

  def update_summary
    if Summary.where(subject_id: params[:subject_id], number: params[:number], deleted: 0).blank?
      page=0
    else
      page=Summary.where(subject_id: params[:subject_id], number: params[:number], deleted: 0).maximum('page')
    end
    summary=Summary.find(params[:id])
    old_file_name=summary.file_name
    summary.subject_id=params[:subject_id]
    summary.number=params[:number]
    summary.page=page+1
    ext=check_content_type(summary.content_type)
    summary.file_name="#{Subject.find(summary.subject_id).title_en}-summary-#{summary.number}-#{summary.page}.#{ext}"
    summary.description=params[:description]
    summary.save

    File.rename(RAILS_ROOT+'/public/files/' + old_file_name, RAILS_ROOT+'/public/files/' + summary.file_name)

    update=SubjectUpdate.new
    update.user_id=session[:user_id]
    update.subject_id=params[:subject_id]
    update.type='更新'
    update.data_type='授業資料'

    redirect_to action: 'subject', id: params[:subject_id]
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
