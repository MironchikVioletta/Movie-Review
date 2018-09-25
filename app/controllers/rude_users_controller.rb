# frozen_string_literal: true

class RudeUsersController < ApplicationController
  def index
    @rude_users = User.rude
  end
end
