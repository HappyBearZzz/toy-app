# encoding: utf-8
class AdminsController < ApplicationController
  skip_before_filter :authorize
  before_filter :authorize_admin,:except => [:adminlogin,:adminlogin_confirm]
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.all.paginate(:page => params[:page], :per_page => 5).order('
                                                               created_at DESC')
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        # format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
        format.html { redirect_to admins_url, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        #format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.html { redirect_to admins_url, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    respond_to do |format|
      if @admin.id == session[:admin_id]
        format.html { redirect_to admins_url, notice: 'Can not delete yourself.' }
        format.json { head :no_content }
      else
        @admin.destroy
        format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def adminlogin
    if Admin.find_by_id(session[:admin_id])
      redirect_to home_url
    else
      render layout: "user"
    end
  end

  def adminlogin_confirm
    if admin = Admin.authenticate(params[:name],params[:password])
      session[:user_id] = nil
      session[:admin_id] = admin.id
      redirect_to home_url
    else
      redirect_to adminlogin_url,:alert=>"invalid name password"
    end
  end

  def adminlogout
    session[:admin_id] = nil
    redirect_to adminlogin_url,:alert=>"logged out"
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:name, :password, :password_confirmation)
    end
end
