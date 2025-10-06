class Hospital < ApplicationRecord
  has_many :doctors, class_name: 'User', foreign_key: 'hospital_id'
end
