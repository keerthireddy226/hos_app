class DoctorsController < ApplicationController
  before_action :authorize_doctor

  def appointments
    render json: current_user.appointments_as_doctor
  end

  # Updated accept method
  def accept
    appointment = Appointment.find(params[:id])

    if appointment.update(status: "accepted")
      # Send email to patient
      NotificationMailer.appointment_confirmed(appointment).deliver_now

      render json: { success: true, appointment: appointment }
    else
      render json: { error: "Unable to accept" }, status: 422
    end
  end


  def cancel
  appointment = Appointment.find(params[:id])
  if appointment.date > 4.hours.from_now
    appointment.update(status: "cancelled")
    # Send email to patient
    NotificationMailer.appointment_canceled(appointment).deliver_now
    render json: appointment
  else
    render json: { error: "Cannot cancel less than 4 hours before appointment" }, status: 400
  end
end

  private

  def authorize_doctor
    render json: { error: "Unauthorized" }, status: :unauthorized unless current_user&.role == "doctor"
  end

  def current_user
    token = request.headers['Authorization']&.split(' ')&.last
    decoded = JWT.decode(token, Rails.application.secret_key_base)[0] rescue nil
    User.find_by(id: decoded["user_id"])
  end
end
