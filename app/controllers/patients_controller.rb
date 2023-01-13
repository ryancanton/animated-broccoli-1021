class PatientsController < ApplicationController
  def index
    @patients = Patient.get_alphabetized_adult_patients
  end
end