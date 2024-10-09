class EventBlueprint < Blueprinter::Base
  fields :id, :start_time, :end_time, :location, :worker_id, :user_id, :weather_info
end
