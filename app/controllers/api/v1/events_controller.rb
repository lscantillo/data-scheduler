class Api::V1::EventsController <  Api::V1::ApplicationController
  after_action { pagy_headers_merge(@pagy) if @pagy }
  before_action :set_event, only: %i[ show destroy ]

  def index
    if params[:worker_id].present?
      @worker = User.find(params[:worker_id])
      @pagy, @events = pagy_array(@worker.assigned_events.order(:start_time))

      render json: { events: JSON.parse(EventBlueprint.render(@events)), pagy: pagy_metadata(@pagy)}, status: :ok
    else
      @pagy, @events = pagy_array(Event.order(:start_time))

      render json: { events: JSON.parse(EventBlueprint.render(@events)), pagy: pagy_metadata(@pagy)}, status: :ok
    end
  end

  def create
    event = Event.new(event_params)

    if event.save
      render json: { result: "Event was successfully created." }, status: :created
    else
      render json: {
        result: "Something went wrong.",
        errors: event.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def show
    event = Event.find(params[:id])
    render json: { event: JSON.parse(EventBlueprint.render(event)) }, status: :ok
  end

  def destroy
    if @event.destroy
      render json: { message: "Event was successfully destroyed." }, status: :ok
    else
      render json: {
        message: "Failed to destroy the event.",
        errors: @event.errors.full_messages
      }, status: :unprocessable_entity
    end
  end


  private

  def set_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Event not found" }, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:title, :start_time, :end_time, :user_id, :worker_id, :location, :weather_info)
  end
end
