class ExamsController < ApplicationController

  layout "subject"

  # GET /exams
  # GET /exams.json
  def index
    @exams = Exam.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @exams }
    end
  end

  # GET /exams/1
  # GET /exams/1.json
  def show
    @exam = Exam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @exam }
    end
  end

  # GET /exams/new
  # GET /exams/new.json
  def new
    @exam = Exam.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @exam }
    end
  end

  # GET /exams/1/edit
  def edit
    @exam = Exam.find(params[:id])
  end

  # POST /exams
  # POST /exams.json
  def create
    @exam = Exam.new
      @exam.subject_id = params[:exam][:subject_id]
      @exam.year = params[:exam][:year]
      @exam.number = params[:exam][:number]
      if params[:exam][:q_a]=="1" then @exam.q_a="a" else @exam.q_a="q" end
      @exam.file = params[:exam][:file].read
      @exam.content_type = params[:exam][:file].content_type
      case @exam.content_type
        when "application/pdf"
          ext = "pdf"
        else
          #TODO redirect_to "new" notice: "invalid file type"
      end
      @exam.file_name =
        "#{Subject.find(@exam.subject_id).page_title}_past-exam_" +
        "#{@exam.year}_#{@exam.number}_#{@exam.q_a}.#{ext}"

    respond_to do |format|
      if @exam.save
        format.html { redirect_to @exam, notice: 'Exam was successfully created.' }
        format.json { render json: @exam, status: :created, location: @exam }
      else
        format.html { render action: "new" }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /exams/1
  # PUT /exams/1.json
  def update
    @exam = Exam.find(params[:id])
      @exam.subject_id = params[:exam][:subject_id]
      @exam.year = params[:exam][:year]
      @exam.number = params[:exam][:number]
      if params[:exam][:q_a]=="1" then @exam.q_a="a" else @exam.q_a="q" end
      unless params[:exam][:file]==nil
        @exam.file = params[:exam][:file].read
        @exam.content_type = params[:exam][:file].content_type
      end
      case @exam.content_type
        when "application/pdf"
          ext = "pdf"
        else
          #TODO redirect_to "new" notice: "invalid file type"
      end
      @exam.file_name =
        "#{Subject.find(@exam.subject_id).page_title}_past-exam_" +
        "#{@exam.year}_#{@exam.number}_#{@exam.q_a}.#{ext}"

    respond_to do |format|
      if @exam.save
        format.html { redirect_to @exam, notice: 'Exam was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.json
  def destroy
    @exam = Exam.find(params[:id])
    @exam.destroy

    respond_to do |format|
      format.html { redirect_to exams_url }
      format.json { head :ok }
    end
  end
end
