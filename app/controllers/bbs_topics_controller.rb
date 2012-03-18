class BbsTopicsController < ApplicationController
  # GET /bbs_topics
  # GET /bbs_topics.json
  def index
    @bbs_topics = BbsTopic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bbs_topics }
    end
  end

  # GET /bbs_topics/1
  # GET /bbs_topics/1.json
  def show
    @bbs_topic = BbsTopic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bbs_topic }
    end
  end

  # GET /bbs_topics/new
  # GET /bbs_topics/new.json
  def new
    @bbs_topic = BbsTopic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bbs_topic }
    end
  end

  # GET /bbs_topics/1/edit
  def edit
    @bbs_topic = BbsTopic.find(params[:id])
  end

  # POST /bbs_topics
  # POST /bbs_topics.json
  def create
    @bbs_topic = BbsTopic.new(params[:bbs_topic])
    @bbs_topic.user_id=session[:user_id]
    @bbs_topic.bbs_group_id=flash[:bbs_group_id]

    respond_to do |format|
      if @bbs_topic.save
        format.html { redirect_to @bbs_topic, notice: 'Bbs topic was successfully created.' }
        format.json { render json: @bbs_topic, status: :created, location: @bbs_topic }
      else
        format.html { render action: "new" }
        format.json { render json: @bbs_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bbs_topics/1
  # PUT /bbs_topics/1.json
  def update
    @bbs_topic = BbsTopic.find(params[:id])

    respond_to do |format|
      if @bbs_topic.update_attributes(params[:bbs_topic])
        format.html { redirect_to @bbs_topic, notice: 'Bbs topic was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bbs_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bbs_topics/1
  # DELETE /bbs_topics/1.json
  def destroy
    @bbs_topic = BbsTopic.find(params[:id])
    @bbs_topic.destroy

    respond_to do |format|
      format.html { redirect_to bbs_topics_url }
      format.json { head :ok }
    end
  end
end
