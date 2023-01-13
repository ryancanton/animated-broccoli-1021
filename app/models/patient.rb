class Patient < ApplicationRecord
  has_many :patient_doctors
  has_many :doctors, through: :patient_doctors

  def self.get_alphabetized_adult_patients
    self.where('patients.age >= ?', 18).order(name: :asc)
  end
end