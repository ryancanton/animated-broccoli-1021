# User Story 1, Doctors Show Page
# ​
# As a visitor
# When I visit a doctor's show page
# I see all of that doctor's information including:
#  - name
#  - specialty
#  - university where they got their doctorate
# And I see the name of the hospital where this doctor works
# And I see the names of all of the patients this doctor has
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
    DoctorPatient.create!(doctor_id: doc_2.id, patient_id: pat_3.id)

    visit doctor_path(doc_1.id)

    expect(page).to have_content(doc_1.name)
    expect(page).to have_content(doc_1.specialty)
    expect(page).to have_content(doc_1.university)
    expect(page).to_not have_content(doc_2.name)
    expect(page).to have_content(hospital.name)
    expect(page).to have_content(pat_1.name)
    expect(page).to have_content(pat_2.name)
    expect(page).to have_content(pat_3.name)
    expect(page).to_not have_content(pat_4.name)
  end
end