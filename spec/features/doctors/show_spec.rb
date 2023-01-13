require 'rails_helper'

RSpec.describe "A Doctor Show Page" do
  it 'contains the doctors information, hospital name, and a list of all their patients' do
    hospital = Hospital.create!(name: "St. Anthony Hospital")
    doc_1 = hospital.doctors.create!(name: "Dr. House", specialty: "Winning", university: "Harvoxale University")
    doc_2 = hospital.doctors.create!(name: "Dr. Bob", specialty: "Losing", university: "University of American Samoa")
    pat_1 = doc_1.patients.create!(name: "Lucy", age: 57)
    pat_2 = doc_1.patients.create!(name: "Billy", age: 43)
    pat_3 = doc_1.patients.create!(name: "Kyle", age: 12)
    pat_4 = doc_2.patients.create!(name: "Jill", age: 21)
    PatientDoctor.create!(doctor_id: doc_2.id, patient_id: pat_3.id)

    visit doctor_path(doc_1.id)

    expect(page).to have_content(doc_1.name)
    expect(page).to have_content(doc_1.specialty)
    expect(page).to have_content(doc_1.university)
    expect(page).to have_no_content(doc_2.name)
    expect(page).to have_content(hospital.name)
    expect(page).to have_content(pat_1.name)
    expect(page).to have_content(pat_2.name)
    expect(page).to have_content(pat_3.name)
    expect(page).to have_no_content(pat_4.name)
  end

  it 'contains a button to remove a patient from caseload, which does not affect other doctors patients' do
    hospital = Hospital.create!(name: "St. Anthony Hospital")
    doc_1 = hospital.doctors.create!(name: "Dr. House", specialty: "Winning", university: "Harvoxale University")
    doc_2 = hospital.doctors.create!(name: "Dr. Bob", specialty: "Losing", university: "University of American Samoa")
    pat_1 = doc_1.patients.create!(name: "Lucy", age: 57)
    pat_2 = doc_1.patients.create!(name: "Billy", age: 43)
    PatientDoctor.create!(doctor_id: doc_2.id, patient_id: pat_1.id)

    visit doctor_path(doc_1.id)

    within "div#patient-#{pat_1.id}" do
      expect(page).to have_button("Remove from Caseload")
      click_button "Remove from Caseload"
    end

    expect(current_path).to eq(doctor_path(doc_1.id))
    expect(page).to have_content(pat_2.name)
    expect(page).to have_no_content(pat_1.name)

    visit doctor_path(doc_2.id)
    expect(page).to have_content(pat_1.name)
  end
end