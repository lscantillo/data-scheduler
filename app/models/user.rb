# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  name                   :string           default(""), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  role                   :integer          default("user"), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  has_many :created_events, class_name: 'Event', dependent: :destroy
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
