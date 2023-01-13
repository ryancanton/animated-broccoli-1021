require 'rails_helper'

RSpec.describe "A Hospital Show Page" do
  it 'contains the hospitals name, and a list of all doctors ordered by their number of patients' do
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

    visit hospital_path(hospital.id)

    expect(page).to have_content(hospital.name)
    expect("Dr. Bob - Patient Count: 3").to appear_before("Dr. Lafayette - Patient Count: 2")
    expect("Dr. Lafayette - Patient Count: 2").to appear_before("Dr. House - Patient Count: 1")
  end
end