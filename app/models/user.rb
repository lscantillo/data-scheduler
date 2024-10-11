class User < ApplicationRecord
  has_many :created_events, class_name: 'Event', foreign_key: 'user_id', dependent: :destroy
  has_many :assigned_events, class_name: 'Event', foreign_key: 'worker_id', dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  enum role: { user: 0, admin: 1 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :workers, -> { where(role: :user) }
end
