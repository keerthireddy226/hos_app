class Appointment < ApplicationRecord
  belongs_to :doctor, class_name: 'User'
  belongs_to :patient, class_name: 'User'
  belongs_to :hospital

  validates :date, presence: true
  validate :appointment_time_valid, on: :create

  def appointment_time_valid
    if date.present? && date < 1.day.from_now
      errors.add(:date, "Appointments must be booked at least 1 day in advance")
    end
  end
end
