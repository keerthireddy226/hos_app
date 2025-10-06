class PatientsController < ApplicationController
  before_action :authorize_patient

  def hospitals
    render json: Hospital.all
  end

  def doctors
    hospital = Hospital.find(params[:hospital_id])
    render json: hospital.doctors
  end

  def book_appointment
    appointment = Appointment.new(
      patient_id: current_user.id,
      doctor_id: params[:doctor_id],
      hospital_id: params[:hospital_id],
      date: params[:date],
      status: "pending"
    )

    if appointment.save
      render json: appointment
    else
      render json: { error: appointment.errors.full_messages }, status: 400
    end
  end

  private

  def authorize_patient
    render json: { error: "Unauthorized" }, status: :unauthorized unless current_user&.role == "patient"
  end

  def current_user
    token = request.headers['Authorization']&.split(' ')&.last
    decoded = JWT.decode(token, Rails.application.secret_key_base)[0] rescue nil
    User.find_by(id: decoded["user_id"])
  end
end
