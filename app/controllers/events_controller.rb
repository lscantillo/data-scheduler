class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events or /events.json
  def index
    if params[:worker_id].present?
      @worker = User.find(params[:worker_id])
      @events = @worker.assigned_events

      sorted_events = Events::SortedService.call(@events)

      @pagy, @events = pagy_array(sorted_events)

    else
      @pagy, @events = pagy_array(Event.order(:start_time))
    end

    respond_to do |format|
      format.html
    end
  end

  # GET /events/1 or /events/1.json
  def show; end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit; end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html do
        redirect_to events_path, status: :see_other, notice: 'Event was successfully destroyed.'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:title, :start_time, :end_time, :user_id, :worker_id,
                                  :location, :weather_info)
  end
end
