require 'rails_helper'

RSpec.describe Hospital do
  describe "relationships" do
    it {should have_many :doctors}
    it {should have_many(:patients).through(:doctors)}
  end

  describe "#get_doctors_by_patient_count" do
    it 'returns a list of all doctors belonging to a hospital ordered by the number of patients' do
      hospital = Hospital.create!(name: "St. Anthony Hospital")
    doc_1 = hospital.doctors.create!(name: "Dr. House", specialty: "Winning", university: "Harvoxale University")
    doc_2 = hospital.doctors.create!(name: "Dr. Bob", specialty: "Losing", university: "University of American Samoa")
    doc_3 = hospital.doctors.create!(name: "Dr. Lafayette", specialty: "Caring", university: "University of College")
    doc_1.patients.create!(name: "Bud", age: 12)
    doc_3.patients.create!(name: "Pal", age: 21)
    doc_3.patients.create!(name: "Guy", age: 13)
    doc_2.patients.create!(name: "Man", age: 31)
    doc_2.patients.create!(name: "Gal", age: 14)
    doc_2.patients.create!(name: "Gus", age: 41)

    hospital_docs = hospital.get_doctors_by_patient_count

    expect(hospital_docs.length).to eq(3)
    expect(hospital_docs[0].patient_count).to eq(3)
    expect(hospital_docs[0]).to eq(doc_2)
    expect(hospital_docs[1].patient_count).to eq(2)
    expect(hospital_docs[1]).to eq(doc_3)
    expect(hospital_docs[2].patient_count).to eq(1)
    expect(hospital_docs[2]).to eq(doc_1)
    end
  end
end
