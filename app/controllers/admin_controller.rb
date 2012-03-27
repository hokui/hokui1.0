class AdminController < ApplicationController
  before_filter :admin_authorize
  layout 'admin'

  def index
  end

  def exams
    if Exam.where(deleted: 0).blank?
      @notice='NO exam files exist.'
    else
      page=( params[:page] ? params[:page] : 1 )
      @exams=Exam.where(deleted: 0)
                 .select('id, subject_id, year, number, q_a, file_name, uploaded_by, deleted')
                 .order('id DESC')
                 .offset(25*(params[:page]-1))
                 .limit(25)
    end
  end

  def delete_exam
    exam=Exam.find(params[:id])
    exam.deleted=1
    exam.deleted_by=session[:user_id]
    exam.save
    redirect_to action: 'exams'
  end

  def quizzes
    if Quiz.where(deleted: 0).blank?
      @notice='NO quiz files exist.'
    else
      page=( params[:page] ? params[:page] : 1 )
      @quizzes=Quiz.where(deleted: 0)
                   .select('id, subject_id, number, q_a, content_type, file_name, uploaded_by, deleted')
                   .order('id DESC')
                   .offset(25*(params[:page]-1))
                   .limit(25)
    end
  end

  def delete_quiz
    quiz=Quiz.find(params[:id])
    quiz.deleted=1
    quiz.deleted_by=session[:user_id]
    quiz.save
    redirect_to action: 'quizzes'
  end

  def summaries
    if Summary.where(deleted: 0).blank?
      @notice='NO summary files exist.'
    else
      page=( params[:page] ? params[:page] : 1 )
      @summaries=Summary.where(deleted: 0)
                        .select('id, subject_id, number, content_type, file_name, uploaded_by, deleted')
                        .order('id DESC')
                        .offset(25*(params[:page]-1))
                        .limit(25)
    end
  end

  def delete_summary
    summary=Summary.find(params[:id])
    summary.deleted=1
    summary.deleted_bysession[:user_id]
    summary.save
    redirect_to action: 'summaries'
  end

  def bbs_topics
    if BbsTopic.where(deleted: 0).blank?
      @notice='NO topics exist.'
    else
      page=( params[:page] ? params[:page] : 1 )
      @bbs_topics=BbsTopic.where(deleted: 0)
                          .select('id, bbs_group_id, user_id, title, deleted')
                          .order('id DESC')
                          .offset(25*(params[:page]-1))
                          .limit(25)
    end
  end

  def delete_bbs_topic
    bbs_topic=BbsTopic.find(params[:id])
    bbs_topic.deleted=1
    bbs_topic.deleted_by=session[:user_id]
    bbs_topic.save
    bbs_bodies=BbsBody.find_by_bbs_topid_id(bbs_topic.id)
    bbs_bodies.each do |bbs_body|
      bbs_body.topic_deleted=1
      bbs_body.save
    end
    redirect_to action: 'bbs_topics'
  end

  def bbs_bodies
    if BbsBody.where(deleted: 0).blank?
      @notice='NO contributions exist.'
    else
      page=( params[:page] ? params[:page] : 1 )
      @bbs_bodies=BbsBody.where(deleted: 0, topic_deleted: 0)
                         .select('id, bbs_topic_id, user_id, text, deleted, topic_deleted, created_at')
                         .order('id DESC')
                         .offset(25*(params[:page]-1))
                         .limit(25)
    end
  end

  def delete_bbs_body
    bbs_body=BbsBody.find(params[:id])
    bbs_body.deleted=1
    bbs_body.deleted_by=session[:user_id]
    bbs_body.save
    redirect_to action: 'bbs_bodies'
  end

  def users
    @system=User.where(authority: 'system')
                .select('id, authority, full_name, handle_name, mail, invited_by')
                .order('id ASC')
    if User.where(authority: 'admin').blank?
      @notice_admin='NO admin users registered.'
    else
      @admin=User.where(authority: 'admin')
                 .select('id, authority, full_name, handle_name, mail, invited_by')
                 .order('id ASC')
    end
    if User.where(authority: 'guest').blank?
      @notice_guest='NO guest users registered.'
    else
      @guest=User.where(authority: 'guest')
                 .select('id, authority, full_name, handle_name, mail, invited_by')
                 .order('id ASC')
    end
  end

  def invite_user
  end

  def register_user
    password_characters=('a'..'z').to_a + (0..9).to_a
    temp_password=(Array.new(8){
                     password_characters[rand(password_characters.size)]
                   }).join
    user=User.new
    user.mail=params[:mail]
    user.invited_by=session[:user_id]
    user.password=temp_password
    user.authority='guest'
    if user.save
      #send_mail
    end
  end
end
