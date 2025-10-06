class NotificationMailer < ApplicationMailer
  default from: "no-reply@edstellar.com"

  def appointment_confirmed(appointment)
    @appointment = appointment
    @patient = appointment.patient
    @doctor = appointment.doctor
    @hospital = appointment.hospital

    mail(to: @patient.email, subject: "Your Appointment is Confirmed")
  end

  def appointment_canceled(appointment)
    @appointment = appointment
    @patient = appointment.patient
    @doctor = appointment.doctor
    @hospital = appointment.hospital

    mail(to: @patient.email, subject: "Your Appointment has been Cancelled")
  end
end
