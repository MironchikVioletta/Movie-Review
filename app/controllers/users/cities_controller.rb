# frozen_string_literal: true

class Users::CitiesController < ApplicationController
  def edit
    @user = current_user || User.new(city: session[:user_city])
  end

  def update
    @user = current_user
    if Users::UpdateCityService.new(city_params, current_user, session).call
      redirect_to root_path, notice: 'City was successfully updated.'
    else
      flash.now[:error] = 'Something went wrong'
      render :edit
    end
  end

  private

  def city_params
    params.require(:user).permit(:city)
  end
end
