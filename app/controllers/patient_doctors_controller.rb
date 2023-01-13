class PatientDoctorsController < ApplicationController
  def destroy
    patient_doctor = PatientDoctor.find_by(patient_id: params[:patient_id], doctor_id: params[:id])
    patient_doctor.destroy
    redirect_to doctor_path(params[:id])
  end
end