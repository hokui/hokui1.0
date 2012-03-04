class BbsBodiesController < ApplicationController
  # GET /bbs_bodies
  # GET /bbs_bodies.json
  def index
    @bbs_bodies = BbsBody.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bbs_bodies }
    end
  end

  # GET /bbs_bodies/1
  # GET /bbs_bodies/1.json
  def show
    @bbs_body = BbsBody.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bbs_body }
    end
  end

  # GET /bbs_bodies/new
  # GET /bbs_bodies/new.json
  def new
    @bbs_body = BbsBody.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bbs_body }
    end
  end

  # GET /bbs_bodies/1/edit
  def edit
    @bbs_body = BbsBody.find(params[:id])
  end

  # POST /bbs_bodies
  # POST /bbs_bodies.json
  def create
    @bbs_body = BbsBody.new(params[:bbs_body])

    respond_to do |format|
      if @bbs_body.save
        @bbs_topic=BbsTopic.find(@bbs_body.bbs_topic_id)
        format.html { redirect_to @bbs_body, notice: 'Bbs body was successfully created.' }
        format.js
        format.json { render json: @bbs_body, status: :created, location: @bbs_body }
      else
        format.html { render action: "new" }
        format.json { render json: @bbs_body.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bbs_bodies/1
  # PUT /bbs_bodies/1.json
  def update
    @bbs_body = BbsBody.find(params[:id])

    respond_to do |format|
      if @bbs_body.update_attributes(params[:bbs_body])
        format.html { redirect_to @bbs_body, notice: 'Bbs body was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bbs_body.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bbs_bodies/1
  # DELETE /bbs_bodies/1.json
  def destroy
    @bbs_body = BbsBody.find(params[:id])
    @bbs_body.destroy

    respond_to do |format|
      format.html { redirect_to bbs_bodies_url }
      format.json { head :ok }
    end
  end
end
