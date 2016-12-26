#encoding:utf-8  
class ChatinfosController < ApplicationController
  include Tubesock::Hijack
  before_action :set_chatinfo, only: [:show, :edit, :update, :destroy]

  def chat_group
    activity_id = params[:activity_id]
    hijack do |tubesock|
      redis_thread = Thread.new do
        Redis.new.subscribe ("chat_group_"+activity_id.to_s) do |on|
          on.message do |channel, message|
            tubesock.send_data message
          end
        end
      end

      tubesock.onopen do
      end
      tubesock.onmessage do |m|
        chatinfo = Chatinfo.new
        chatinfo.activity_id = activity_id
        chatinfo.user_id = session[:user_id]
        chatinfo.content = m.to_s.chomp.force_encoding("utf-8")
        chatinfo.save
        Redis.new.publish ("chat_group_" + activity_id), User.find_by_id(session[:user_id]).name + ":" + m.to_s
      end

      tubesock.onclose do
        redis_thread.kill
      end
    end
  end
  
  def enter_chat
    @activity_id = params[:activity_id]
  end
  
  def group_history
    activity_id = params[:activity_id]
    activity = Activity.find_by_id(activity_id)
    @chatinfos = activity.chatinfos.paginate(:page => params[:page], :per_page => 5).order('
                                                               created_at asc')
  end
  
  # GET /chatinfos
  # GET /chatinfos.json
  def index
    @chatinfos = Chatinfo.all
  end

  # GET /chatinfos/1
  # GET /chatinfos/1.json
  def show
  end

  # GET /chatinfos/new
  def new
    @chatinfo = Chatinfo.new
  end

  # GET /chatinfos/1/edit
  def edit
  end

  # POST /chatinfos
  # POST /chatinfos.json
  def create
    @chatinfo = Chatinfo.new(chatinfo_params)

    respond_to do |format|
      if @chatinfo.save
        format.html { redirect_to @chatinfo, notice: 'Chatinfo was successfully created.' }
        format.json { render :show, status: :created, location: @chatinfo }
      else
        format.html { render :new }
        format.json { render json: @chatinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chatinfos/1
  # PATCH/PUT /chatinfos/1.json
  def update
    respond_to do |format|
      if @chatinfo.update(chatinfo_params)
        format.html { redirect_to @chatinfo, notice: 'Chatinfo was successfully updated.' }
        format.json { render :show, status: :ok, location: @chatinfo }
      else
        format.html { render :edit }
        format.json { render json: @chatinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatinfos/1
  # DELETE /chatinfos/1.json
  def destroy
    @chatinfo.destroy
    respond_to do |format|
      format.html { redirect_to chatinfos_url, notice: 'Chatinfo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chatinfo
      @chatinfo = Chatinfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chatinfo_params
      params.require(:chatinfo).permit(:activity_id, :user_id, :content)
    end
end
