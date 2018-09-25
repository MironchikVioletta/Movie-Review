# frozen_string_literal: true

class KidsController < ApplicationController
  def index
    @kids = User.kids
  end
end
