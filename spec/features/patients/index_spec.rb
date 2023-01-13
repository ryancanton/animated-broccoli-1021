require 'rails_helper'

RSpec.describe "The Patients Index page" do
  it 'contains a list of all patients over 18 in ascending alphabetical order' do
    pat_1 = Patient.create!(name: "Zachary", age: 19)
    pat_2 = Patient.create!(name: "Billy", age: 12)
    pat_3 = Patient.create!(name: "Linda", age: 24)
    pat_4 = Patient.create!(name: "Sammy", age: 86)
    pat_5 = Patient.create!(name: "Houdini", age: 21)
    pat_6 = Patient.create!(name: "Craig", age: 34)

    visit patients_path

    expect(page).to have_no_content("Billy")

    expect(pat_6.name).to appear_before(pat_5.name)
    expect(pat_5.name).to appear_before(pat_3.name)
    expect(pat_3.name).to appear_before(pat_4.name)
    expect(pat_4.name).to appear_before(pat_1.name)
  end
end