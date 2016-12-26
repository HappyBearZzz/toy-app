class MessagesController < ApplicationController 
  include Tubesock::Hijack
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  
  def chat_onetoone
    to_userid = params[:to_userid]
    hijack do |tubesock|
      redis_thread = Thread.new do
        
        Redis.new.subscribe ("chat_onetoone_"+session[:user_id].to_s+"_"+to_userid.to_s) do |on|
          on.message do |channel, message|
            tubesock.send_data message
          end
        end
        
        Redis.new.subscribe ("chat_onetoone_"+to_userid.to_s+"_"+session[:user_id].to_s) do |on|
          on.message do |channel, message|
            tubesock.send_data message
          end
        end
      end

      tubesock.onopen do
      end
      tubesock.onmessage do |m|
        message = Message.new
        message.from_userid = session[:user_id]
        message.to_userid = to_userid
        message.content = m.to_s.chomp.force_encoding("utf-8")
        message.save()
        Redis.new.publish ("chat_onetoone_"+session[:user_id].to_s+"_"+to_userid.to_s), User.find_by_id(session[:user_id]).name + ":" + m.to_s
        Redis.new.publish ("chat_onetoone_"+to_userid.to_s+"_"+session[:user_id].to_s), User.find_by_id(session[:user_id]).name + ":" + m.to_s
      end

      tubesock.onclose do
        redis_thread.kill
      end
    end
  end 
  
  def two_chat
    @to_userid = params[:to_userid]
  end
  
  def peer_history
    to_userid = params[:to_userid]
    from_userid = session[:user_id]
    @messages = Message.where([ "(to_userid = ? and from_userid = ?) or (to_userid = ? and from_userid = ?) ", to_userid, from_userid, from_userid, to_userid])
    .paginate(:page => params[:page], :per_page => 5).order("created_at asc")
    
    
  end
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:from_userid, :to_userid, :content)
    end
end
