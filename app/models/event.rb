class Event < ApplicationRecord
  validates :title, :start_time, :end_time, presence: true
  validate :no_conflicting_events

  belongs_to :user, class_name: 'User'
  belongs_to :worker, class_name: 'User'

  def no_conflicting_events
    conflicts = Event.where(worker_id: worker_id)
                     .where("start_time < ? AND end_time > ?", end_time, start_time)
    errors.add(:base, 'Conflicting event') if conflicts.exists?
  end
end
