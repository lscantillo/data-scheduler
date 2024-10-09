class EventJob < ApplicationJob
  queue_as :mailer

  def perform(event)
    EventMailer.new_event(event).deliver_now
  end

end
