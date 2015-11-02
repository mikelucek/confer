class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def twilio_number
  	if Rails.application.secrets.twilio_number
  		@twilio_number = Rails.application.secrets.twilio_number
  	end
  end
end
