class BbsGroupsController < ApplicationController
  # GET /bbs_groups
  # GET /bbs_groups.json
  def index
    @bbs_groups = BbsGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bbs_groups }
    end
  end

  # GET /bbs_groups/1
  # GET /bbs_groups/1.json
  def show
    @bbs_group = BbsGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bbs_group }
    end
  end

  # GET /bbs_groups/new
  # GET /bbs_groups/new.json
  def new
    @bbs_group = BbsGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bbs_group }
    end
  end

  # GET /bbs_groups/1/edit
  def edit
    @bbs_group = BbsGroup.find(params[:id])
  end

  # POST /bbs_groups
  # POST /bbs_groups.json
  def create
    @bbs_group = BbsGroup.new
    @bbs_group.title=params[:bbs_group][:title]
    @bbs_group.is_a_term=0

    respond_to do |format|
      if @bbs_group.save
        format.html { redirect_to @bbs_group, notice: 'Bbs group was successfully created.' }
        format.json { render json: @bbs_group, status: :created, location: @bbs_group }
      else
        format.html { render action: "new" }
        format.json { render json: @bbs_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bbs_groups/1
  # PUT /bbs_groups/1.json
  def update
    @bbs_group = BbsGroup.find(params[:id])

    respond_to do |format|
      if @bbs_group.update_attributes(params[:bbs_group])
        format.html { redirect_to @bbs_group, notice: 'Bbs group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bbs_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bbs_groups/1
  # DELETE /bbs_groups/1.json
  def destroy
    @bbs_group = BbsGroup.find(params[:id])
    @bbs_group.destroy

    respond_to do |format|
      format.html { redirect_to bbs_groups_url }
      format.json { head :ok }
    end
  end
end
