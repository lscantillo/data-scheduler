class EventMailer < ApplicationMailer
  def new_event(event)
    @event = event
    @user = @event.user
    @worker = @event.worker

    mail(
      to: [@user.email, @worker.email],
      subject: "New Event: #{@event.title}"
    ) do |format|
      format.html { render 'new_event' }
    end

  end
end
