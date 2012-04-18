class SummariesController < ApplicationController
  before_filter :admin_authorize, except: [:new, :create, :download]

  layout "admin"

  # GET /summaries
  # GET /summaries.json
  def index
    @summaries = Summary.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @summaries }
    end
  end

  # GET /summaries/1
  # GET /summaries/1.json
  def show
    @summary = Summary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @summary }
    end
  end

  # GET /summaries/new
  # GET /summaries/new.json
  def new
    @summary = Summary.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @summary }
    end
  end

  # GET /summaries/1/edit
  def edit
    @summary = Summary.find(params[:id])
  end

  # POST /summaries
  # POST /summaries.json
  def create
    @summary = Summary.new
      @summary.subject_id = params[:summary][:subject_id]
      @summary.number = params[:summary][:number]
      @summary.file = params[:summary][:file].read
      @summary.content_type = params[:summary][:file].content_type
      case @summary.content_type
        when "application/pdf"
          ext = "pdf"
        else
          redirect_to "new", notice: "invalid file type"
      end
      @summary.file_name =
        "#{Subject.find(@summary.subject_id).page_title}-summary-" +
        "#{@summary.number}.#{ext}"

    respond_to do |format|
      if @summary.save
        format.html { redirect_to "/subject/#{@summary.subject_id}", notice: 'Summary was successfully created.' }
        format.json { render json: @summary, status: :created, location: @summary }
      else
        format.html { render action: "new" }
        format.json { render json: @summary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /summaries/1
  # PUT /summaries/1.json
  def update
    @summary = Summary.find(params[:id])
      @summary.subject_id = params[:summary][:subject_id]
      @summary.number = params[:summary][:number]
      unless params[:summary][:file]==nil
        @summary.file = params[:summary][:file].read
        @summary.content_type = params[:summary][:file].content_type
      end
      case @summary.content_type
        when "application/pdf"
          ext = "pdf"
        else
          #TODO redirect_to "new" notice: "invalid file type"
      end
      @summary.file_name =
        "#{Subject.find(@summary.subject_id).page_title}-summary-" +
        "#{@summary.number}.#{ext}"

    respond_to do |format|
      if @summary.update_attributes(params[:summary])
        format.html { redirect_to @summary, notice: 'Summary was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @summary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /summaries/1
  # DELETE /summaries/1.json
  def destroy
    @summary = Summary.find(params[:id])
    @summary.destroy

    respond_to do |format|
      format.html { redirect_to summaries_url }
      format.json { head :ok }
    end
  end

  def download
    summary = Summary.find(params[:id])

    send_file(RAILS_ROOT+'/public/files/' + summary.file_name, filename: summary.file_name, content_type: summary.content_type)
  end
end
