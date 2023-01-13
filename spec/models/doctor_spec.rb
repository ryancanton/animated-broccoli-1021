require 'rails_helper'

RSpec.describe Doctor do
  describe "relationships" do
    it {should belong_to :hospital}
    it {should have_many :patient_doctors}
    it {should have_many(:patients).through(:patient_doctors)}
  end

  describe "#hospital_name" do
    it 'returns the name of the hospital the doctor belongs to' do
      hospital = Hospital.create!(name: "St. Anthony Hospital")
      doc_1 = hospital.doctors.create!(name: "Dr. House", specialty: "Winning", university: "Harvoxale University")

      expect(doc_1.hospital_name).to eq("St. Anthony Hospital")
    end
  end
end
