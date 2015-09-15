class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def query
    @event = Event.all

     
    @uniq_domains = Event.select( :domain ).uniq.order(:domain).map{|x| [x.domain]}
    @uniq_app = Event.select( :app_name ).uniq.order(:app_name).map{|x| [x.app_name]}
    @uniq_users = Event.select( :user_id ).uniq(:user_id).map{|x| [x.user_id]}
    @results = Event.select( :user_id)    

  end


  # GET /events
  # GET /events.json
  def index

    logger.info "informational message"

    @events = Event.filter(params.slice(:app_name, :user_id, :user_type, :tenant, :url, :domain, :duration, :search_words, :push_start_time, :push_end_time))


    ##filtering_params(params).each do |key, value|
    #  #@events = @events.public_send(key, value) if value.present?
    ##end

    @uniq_domains = Event.select( :domain ).uniq.order(:domain).map{|x| [x.domain]}
    @uniq_app = Event.select( :app_name ).uniq.order(:app_name).map{|x| [x.app_name]}
    @uniq_users = Event.select( :user_id ).uniq(:user_id).map{|x| [x.user_id]}
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:app_name, :user_id, :user_type, :tenant, :url, :domain, :duration, :search_words, :push_start_time, :end_time_stamp)
    end

  def filtering_params(params)
    params.slice(:app_name, :user_id, :user_type, :tenant, :url, :domain, :duration, :search_words, :push_start_time, :end_time_stamp)
  end

end

