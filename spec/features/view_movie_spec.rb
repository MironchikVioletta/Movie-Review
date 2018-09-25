# frozen_string_literal: true

require 'rails_helper'

describe 'the view movie process', type: :feature do
  include LogInSpecHelper

  context 'registered user', js: true do
    let(:user) { create(:user) }
    let!(:movie) { create(:movie) }

    before do
      log_in(user.email, user.password)
    end

    it 'view movie', js: true do
      visit '/'
      find("img[data-movie-id='#{movie.id}']").click

      expect(page).to have_css('h1', text: movie.title.to_s)
    end
  end
end
