# encoding: utf-8
class ParticipationsController < ApplicationController
  skip_before_filter :authorize
  before_action :set_participation, only: [:show, :edit, :update, :destroy]

  # GET /participations
  # GET /participations.json
  def index
    if params[:user_id]
      user = User.find_by_id(params[:user_id])
      @participations = user.participations.paginate(:page => params[:page], :per_page => 5).order('
                                                               created_at DESC')
    else
      @participations = Participation.all.paginate(:page => params[:page], :per_page => 5).order('
                                                               created_at DESC')
    end
  end

  # GET /participations/1
  # GET /participations/1.json
  def show
  end

  # GET /participations/new
  def new
    @participation = Participation.new
  end

  # GET /participations/1/edit
  def edit
  end

  # POST /participations
  # POST /participations.json
  def create
    @participation = Participation.new(participation_params)

    respond_to do |format|
      if @participation.save
        format.html { redirect_to @participation, notice: 'Participation was successfully created.' }
        format.json { render :show, status: :created, location: @participation }
      else
        format.html { render :new }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participations/1
  # PATCH/PUT /participations/1.json
  def update
    respond_to do |format|
      if @participation.update(participation_params)
        format.html { redirect_to @participation, notice: 'Participation was successfully updated.' }
        format.json { render :show, status: :ok, location: @participation }
      else
        format.html { render :edit }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participations/1
  # DELETE /participations/1.json
  def destroy
    @participation.destroy
    respond_to do |format|
      format.html { redirect_to participations_url, notice: 'Participation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
    def addtoactivity
    user = User.find_by_id(session[:user_id])
    participation = user.participations.new
    activity_id = params[:activity_id]
    logger.info "activity_id"+activity_id.to_s
    participation.activity_id = activity_id
    participation.status = 'apply_for'
    respond_to do |format|
      if participation.save
        format.html { redirect_to participations_path, notice: 'Participation was successfully created.' }
        format.json { render :show, status: :created, location: @participation }
      else
        format.html { render :new }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def approve_participation
    update_participation('approved')
  end
  
  def refuse_participation
    update_participation('refused')
  end
  
  def update_participation(type)
    participation_id = params[:participation_id]
    participation = Participation.find_by_id(participation_id)
    activity_id = params[:activity_id]
    activities = Activity.find_by_id(activity_id)
    respond_to do |format|
      if participation.update_attribute(:status, type)
        # format.html { redirect_to @participation, notice: 'Participation was successfully updated.' }
        format.html { redirect_to activities, notice: 'Participation was successfully updated.' }
        format.json { render :show, status: :ok, location: @participation }
      else
        format.html { render :edit }
        # format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participation
      @participation = Participation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participation_params
      params.require(:participation).permit(:status, :activity_id, :user_id)
    end
end
