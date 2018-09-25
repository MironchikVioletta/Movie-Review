# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = scoped_users
    # @users = User.all
  end

  def show
    @user = scoped_users.find(params[:id])
  end

  def toggle_block
    @user = scoped_users.find(params[:id])
    @user.update(blocked: !@user.blocked)
    redirect_to @user
  end

  private

  def scoped_users
    User.unscoped.all
  end
end
