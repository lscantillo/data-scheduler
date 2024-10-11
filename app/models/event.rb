# == Schema Information
#
# Table name: events
#
#  id           :bigint           not null, primary key
#  title        :string
#  start_time   :datetime
#  end_time     :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  worker_id    :integer
#  user_id      :integer
#  location     :string
#  weather_info :jsonb
#
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
    return unless location.present?

    weather_info = WeatherService.fetch_weather(location)
    self.weather_info = weather_info if weather_info.present?
  end

  def no_conflicting_events
    conflicts = Event.where(worker_id:)
                     .where('start_time < ? AND end_time > ?', end_time, start_time)
    errors.add(:base, 'Conflicting event') if conflicts.exists?
  end
end
