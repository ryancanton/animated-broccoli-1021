require 'rails_helper'

RSpec.describe Patient do
  describe "relationships" do
    it {should have_many :patient_doctors}
    it {should have_many(:doctors).through(:patient_doctors)}
  end

  describe "#self.get_alphabetized_adult_patients" do
    it 'returns all patients over 18 in alphabetical order' do
      pat_1 = Patient.create!(name: "Zachary", age: 19)
      pat_2 = Patient.create!(name: "Billy", age: 12)
      pat_3 = Patient.create!(name: "Linda", age: 24)
      pat_4 = Patient.create!(name: "Sammy", age: 86)
      pat_5 = Patient.create!(name: "Houdini", age: 21)
      pat_6 = Patient.create!(name: "Craig", age: 34)

      expect(Patient.get_alphabetized_adult_patients).to eq([pat_6, pat_5, pat_3, pat_4, pat_1])
    end
  end
end