class QuizzesController < ApplicationController
  before_filter :admin_authorize, except: [:new, :create]

  layout "admin"

  # GET /quizzes
  # GET /quizzes.json
  def index
    @quizzes = Quiz.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quizzes }
    end
  end

  # GET /quizzes/1
  # GET /quizzes/1.json
  def show
    @quiz = Quiz.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quiz }
    end
  end

  # GET /quizzes/new
  # GET /quizzes/new.json
  def new
    @quiz = Quiz.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quiz }
    end
  end

  # GET /quizzes/1/edit
  def edit
    @quiz = Quiz.find(params[:id])
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
    @quiz = Quiz.new
      @quiz.subject_id = params[:quiz][:subject_id]
      @quiz.number = params[:quiz][:number]
      if params[:quiz][:q_a]=="1" then @quiz.q_a="a" else @quiz.q_a="q" end
      @quiz.file = params[:quiz][:file].read
      @quiz.content_type = params[:quiz][:file].content_type
      case @quiz.content_type
        when "application/pdf"
          ext = "pdf"
        else
          redirect_to "new", notice: "invalid file type"
      end
      @quiz.file_name =
        "#{Subject.find(@quiz.subject_id).page_title}-quiz-" +
        "#{@quiz.number}-#{@quiz.q_a}.#{ext}"

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to @quiz, notice: 'Quiz was successfully created.' }
        format.json { render json: @quiz, status: :created, location: @quiz }
      else
        format.html { render action: "new" }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quizzes/1
  # PUT /quizzes/1.json
  def update
    @quiz = Quiz.find(params[:id])
      @quiz.subject_id = params[:quiz][:subject_id]
      @quiz.number = params[:quiz][:number]
      if params[:quiz][:q_a]=="1" then @quiz.q_a="a" else @quiz.q_a="q" end
      unless params[:quiz][:file]==nil
        @quiz.file = params[:quiz][:file].read
        @quiz.content_type = params[:quiz][:file].content_type
      end
      case @quiz.content_type
        when "application/pdf"
          ext = "pdf"
        else
          #TODO redirect_to "new" notice: "invalid file type"
      end
      @quiz.file_name =
        "#{Subject.find(@quiz.subject_id).page_title}-quiz-" +
        "#{@quiz.number}-#{@quiz.q_a}.#{ext}"

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to @quiz, notice: 'Quiz was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy

    respond_to do |format|
      format.html { redirect_to quizzes_url }
      format.json { head :ok }
    end
  end

  def download
    quiz = Quiz.find(params[:id])

    send_file(RAILS_ROOT+'/public/files/' + quiz.file_name, filename: quiz.file_name, content_type: quiz.content_type)
  end
end
