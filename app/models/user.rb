class User < ApplicationRecord
  # Security
  audited
  has_secure_password
  has_many :sessions, dependent: :destroy
  # Content Enrollment(s)
  has_one :enrollment, dependent: :destroy
  has_one :course, through: :enrollment
  has_many :units, through: :course
  has_many :topics, through: :units
  has_many :assignments, through: :units
  has_many :course_ownerships, dependent: :destroy
  has_many :owned_courses, through: :course_ownerships, source: :course
  # Messaging/Notifications
  has_many :messages, dependent: :destroy
  has_many :mentions, dependent: :destroy
  has_many :mentioned_messages, through: :mentions, source: :message
  # Private convo stuff
  has_many :conversation_users, dependent: :destroy
  has_many :conversations, through: :conversation_users

  # Avatar Stuff ('ake Sulleyyy')
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 100, 100 ]
  end

  has_many :notebooks, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :account_type, inclusion: %w[student teacher administrator]

  enum :account_type, {
    student: 0,
    teacher: 1,
    administrator: 2
  }

  def full_name
    "#{first_name} #{last_name}"
  end

  def authorised?(course = nil)
    administrator? || (course.present? && course.owners.include?(self))
  end
end
