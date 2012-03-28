class UsersController < ApplicationController
  before_filter :admin_authorize, except: [:edit, :update, :change_password, :update_password]
  before_filter :system_authorize, only: [:invite_from_list, :register_list]
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(session[:user_id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new
    @user.mail=params[:user][:mail]
    temp_password=create_random_password
    @user.password=temp_password
    @user.invited_by=session[:user_id]

    respond_to do |format|
      if @user.save
        # TODO send_register_confirmation_mail(@user.mail,temp_password)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to '/', notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

  def change_password
    @user = User.find(session[:user_id])
  end

  def update_password
    if params[:new_password]!=params[:new_password_confirm]
      redirect_to action: 'change_password'
      return
    end

    @user=User.find(session[:user_id])
    if @user.authenticate(params[:password])
      @user.password=params[:new_password]
      @user.save
      redirect_to "/profile"
    else
      redirect_to action: 'change_password'
    end
  end

  def invite_from_list
  end

  def register_list
    data=params[:list]
    linedata=data.split(/(\r\n?|\n?)/)
    linedata.each do |line|
      temp_password=create_random_password
      if User.new(mail: line, password: temp_password, invited_by: session[:user_id]).save
        # TODO send_register_confirmation_mail(line,temp_password)
      end
    end
  end

  def create_random_password
    letters=('a'..'z').to_a + ('0'..'9').to_a
    random_string=(Array.new(8) { letters[rand(letters.size)] }).join
    return random_string
  end
end
