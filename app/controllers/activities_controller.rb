class ActivitiesController < ApplicationController
  # skip_before_filter :authorize,:except => :new
  skip_before_filter :authorize,:except => :new
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /activities
  # GET /activities.json
  def index
    if params[:user_id]
      user = User.find_by_id(params[:user_id])
      @activities = user.activities.paginate(:page => params[:page], :per_page => 5).order('
                                                               created_at DESC')
    else
      @activities = Activity.all.paginate(:page => params[:page], :per_page => 5).order('
                                                               created_at DESC')
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    
    @comments = Comment.where('activity_id = '+params[:id])
    
  end

  # GET /activities/new
  def new
    if session[:user_id]
      @activity = Activity.new
    else
      redirect_to login_url
    end
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:title, :content, :category, :start_at, :end_at, :location, :user_id)
    end
end
