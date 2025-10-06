class User < ApplicationRecord
  has_secure_password

  has_many :appointments_as_patient, class_name: 'Appointment', foreign_key: :patient_id
  has_many :appointments_as_doctor, class_name: 'Appointment', foreign_key: :doctor_id
  belongs_to :hospital, optional: true

  validates :email, uniqueness: true
end
