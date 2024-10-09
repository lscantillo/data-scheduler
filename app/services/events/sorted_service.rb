# frozen_string_literal: true

module Events
  class SortedService
    def self.call(events)
      today_events = events.where(start_time: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)

      future_events = events.where('start_time > ?', Time.zone.now.end_of_day)

      past_events = events.where('start_time < ?', Time.zone.now.beginning_of_day)

      (today_events || future_events || past_events).order(:start_time)
    end
  end
end
