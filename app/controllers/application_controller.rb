# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_сity

  def user_city
    return current_user.city if current_user&.city.present?
    session[:user_city]
  end
  helper_method :user_city

  protected

  def configure_permitted_parameters
    registration_params = %i[email password password_confirmation age premium blocked city]

    if params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(registration_params)
      end
    end
  end

  def set_user_сity
    # NOTE: the same as:
    #   session[:user_city] || (session[:user_city] = city_from_request)
    session[:user_city] ||= city_from_request
  end

  def city_from_request
    if Rails.env.production?
      request.location.city
    else
      'City 17'
    end
  end
end
