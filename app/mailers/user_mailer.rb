class UserMailer < ApplicationMailer
  default from: 'info@mealville.xyz'

  def booking_request_email
    @user = params[:user]
    @event = params[:event]

    mail(to: @user.email, subject: "You have a request for a booking.")
  end

  def booking_confirm_email
    @user = params[:user]
    @booking = params[:booking]
    mail(to: @user.email, subject: "Your booking has been confirmed.")
  end

  def booking_cancel_email
    @user = params[:user]
    @booking = params[:booking]
    mail(to: @user.email, subject: "A booking to your event has been cancelled.")
  end
end
