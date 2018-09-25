# frozen_string_literal: true

require 'rails_helper'

describe 'the display recently viewd mivies process', type: :feature do
  include LogInSpecHelper
  let!(:movie) { create(:movie) }

  context 'unregistered user', js: true do
    it 'display recently viewd mivies in footer' do
      visit '/'
      find('img.movie_poster').click
      click_link 'Back'

      expect(page).to have_css 'img.visited_movie_poster'
    end
  end

  context 'registered user', js: true do
    let(:user) { create(:user) }

    it 'display recently viewed movies in footer' do
      visit '/'
      find('img.movie_poster').click
      click_link 'Back'

      expect(page).to have_css 'img.visited_movie_poster'
    end
  end
end
