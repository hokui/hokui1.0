class SystemController < ApplicationController
  before_filter :system_authorize
  layout 'system'

  def index
  end

  def terms
    if Term.all.blank?
      @notice='NO terms registered.'
    else
      @terms=Term.all
    end
  end

  def new_term
  end

  def edit_term
    @term=Term.find(params[:id])
  end

  def create_term
    bbs_group=BbsGroup.new
    bbs_group.title=params[:title]
    bbs_group.is_a_term=1
    bbs_group.save
    term=Term.new
    term.title=params[:title]
    term.bbs_group_id=bbs_group.id
    term.save
    redirect_to action: 'terms'
  end

  def update_term
    term=Term.find(params[:id])
    term.title=params[:title]
    term.save
    bbs_group=BbsGroup.find(term.bbs_group_id)
    bbs_group.title=params[:title]
    bbs_group.save
    redirect_to action: 'terms'
  end

  def subjects
    if Subject.all.blank?
      @notice='NO subjects registered.'
    else
      @subjects=Subject.all
    end
  end

  def new_subject
  end

  def edit_subject
    @subject=Subject.find(params[:id])
  end

  def create_subject
    bbs_topic=BbsTopic.new
    bbs_topic.title=params[:title_ja]
    bbs_topic.user_id=session[:user_id]
    bbs_topic.deleted=0
    bbs_topic.bbs_group_id=Term.find(params[:term_id]).bbs_group_id
    bbs_topic.save
    subject=Subject.new
    subject.title_ja=params[:title_ja]
    subject.title_en=params[:title_en]
    subject.term_id=params[:term_id]
    subject.bbs_topic_id=bbs_topic.id
    subject.teacher=params[:teacher]
    subject.save
    redirect_to action: 'subjects'
  end

  def update_subject
    subject=Subject.find(params[:id])
    subject.title_ja=params[:title_ja]
    subject.title_en=params[:title_en]
    subject.term_id=params[:term_id]
    subject.teacher=params[:teacher]
    subject.save
    bbs_topic=BbsTopic.find(subject.bbs_topic_id)
    bbs_topic.title=params[:title]
    bbs_topic.save
    redirect_to action: 'subjects'
  end

  def bbs_groups
    if BbsGroup.all.blank?
      @notice='NO BBS groups registered.'
    else
      @bbs_groups=BbsGroup.all
    end
  end

  def new_bbs_group
  end

  def edit_bbs_group
    @bbs_group=BbsGroup.find(params[:id])
  end

  def create_bbs_group
    bbs_group=BbsGroup.new
    bbs_group.title=params[:title]
    bbs_group.is_a_term=0
    bbs_group.save
    redirect_to action: 'bbs_groups'
  end

  def update_bbs_group
    bbs_group=BbsGroup.find(params[:id])
    bbs_group.title=params[:title]
    bbs_group.save
    redirect_to action: 'bbs_groups'
  end

  def users_detail
    @system=User.find_all_by_authority('system')
    if User.find_by_authority('admin').blank?
      @notice_admin='NO admin users registered.'
    else
      @admin=User.find_all_by_authority('admin')
    end
    if User.find_by_authority('guest').blank?
      @notice_guest='NO guest users registered.'
    else
      @guest=User.find_all_by_authority('guest')
    end
  end

  def invite_users_from_list
  end

  def register_users_from_list
    data_rows=params[:list].split(/(\r\n?|\n?)/)
    linedata.each do |line|
      register_user(line)
    end
    redirect_to action: 'users_detail'
  end

  def register_user(mail)
    password_characters=('a'..'z').to_a + (0..9).to_a
    temp_password=(Array.new(8){
                     password_characters[rand(password_characters.size)]
                   }).join
    user=User.new
    user.mail=mail
    user.invited_by=session[:user_id]
    user.password=temp_password
    user.authority='guest'
    if user.save
      #send_mail
    end
  end

  def edit_user_authority
    @user=User.find(params[:id])
  end

  def update_user_authority
    user=User.find(params[:id])
    user.authority=params[:authority]
    user.save
    redirect_to action: 'users_detail'
  end

  def delete_user
    User.find(params[:id]).destroy
    redirect_to action: 'users_detail', notice: 'The user was successfully deleted.'
  end
end
