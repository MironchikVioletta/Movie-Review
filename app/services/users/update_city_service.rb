# frozen_string_literal: true

class Users::UpdateCityService
  attr_reader :params
  attr_reader :current_user
  attr_reader :session

  def initialize(params, current_user, session)
    @params = params
    @current_user = current_user
    @session = session
  end

  def call
    if current_user.present?
      current_user.update(params)
    else
      session[:user_city] = params[:city]
      true
    end
  end
end
