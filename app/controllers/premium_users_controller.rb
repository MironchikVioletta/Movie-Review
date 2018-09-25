# frozen_string_literal: true

class PremiumUsersController < ApplicationController
  def index
    @premium_users = User.premium
  end
end
