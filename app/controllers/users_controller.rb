# encoding: utf-8
class UsersController < ApplicationController
  skip_before_filter :authorize,:except => :change_password
  before_filter :authorize_admin, :only => :index
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 5).order('
                                                               created_at DESC')
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    render layout: "user"
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.sex = "Male"
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        # format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.html { redirect_to home_url, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        #format.html { render :new }
	format.html { redirect_to register_url, notice: 'Validation fails.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        # format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.html { render :show, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def change_password
  end

  def update_password
    respond_to do |format|
      if user = User.authenticate(User.find_by_id(session[:user_id]).name,params[:old_password])
        if params[:password] == params[:password_confirmation]
          user.password = params[:password]
          if user.update_attribute(:password, params[:password])
            session[:user_id] = nil
            format.html { redirect_to login_path, notice: 'User password was successfully updated.' }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { redirect_to register_path, notice: 'update password failed' }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        else
          format.html { redirect_to change_password_path, notice: 'not the same password' }
        end
      else
        format.html { redirect_to change_password_path, notice: 'invalid old password' }
        # redirect_to 'change_password',:alert=>"invalid old password"
      end
    end
      
  end
  
  def set_password
    user_id = params[:user_id]
    @user = User.find_by_id(user_id)

  end

  def reset_password
    respond_to do |format|
        if params[:password] == params[:password_confirmation]

          user = User.find_by_id(params[:id])
          if user.update_attribute(:password, params[:password])

            format.html { redirect_to users_path, notice: 'User password was successfully updated.' }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { redirect_to users_path, notice: 'update password failed' }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        else
          format.html { redirect_to users_path, notice: 'not the same password' }
        end

    end
      
  end

  def login
    if session[:user_id]
      redirect_to home_url
    else
      render layout: "user"
    end
  end

  def login_confirm
    if user = User.authenticate(params[:name],params[:password])
      session[:admin_id] = nil
      session[:user_id] = user.id
      redirect_to home_url
    else
      redirect_to login_url,:alert=>"invalid name password"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_url,:alert=>"logged out"
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :hashed_password, :no, :age, :sex, :college, :major, :school_year, :description, :password, :password_confirmation, :old_password, :avatar, :avatar_cache)
    end
end
