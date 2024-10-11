class Event < ApplicationRecord
  validates :title, :start_time, :end_time, presence: true
  validate :no_conflicting_events

  belongs_to :user, class_name: 'User'
  belongs_to :worker, class_name: 'User'

  before_save :fetch_weather_info
  after_save :send_email

  def send_email
    EventJob.perform_later(self)
  end

  def fetch_weather_info
    if location.present?
      weather_info = WeatherService.fetch_weather(location)
      self.weather_info = weather_info if weather_info.present?
    end
  end

  def no_conflicting_events
    conflicts = Event.where(worker_id: worker_id)
                     .where("start_time < ? AND end_time > ?", end_time, start_time)
    errors.add(:base, 'Conflicting event') if conflicts.exists?
  end
end
