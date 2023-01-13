class Hospital < ApplicationRecord
  has_many :doctors
  has_many :patients, through: :doctors

  def get_doctors_by_patient_count
    self.doctors.select('doctors.*, count(patients) as patient_count').joins(:patients).group(:id).order(patient_count: :desc)
  end
end
