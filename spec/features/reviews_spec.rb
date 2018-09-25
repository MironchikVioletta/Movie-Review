# frozen_string_literal: true

require 'rails_helper'

describe 'the writing review process', type: :feature do
  include LogInSpecHelper
  context 'registered user' do
    let(:user) { create(:user) }
    let!(:movie) { create(:movie) }
    let(:new_text_review) { 'Cool' }
    let(:star_rating_value) { 'good' }

    before do
      log_in(user.email, user.password)
    end

    it 'successfully wrire review', js: true do
      visit "/movies/#{movie.id}"
      click_link 'Write Review'
      find("#star-rating img[title=#{star_rating_value}]").click
      fill_in 'Comment', with: new_text_review
      click_button 'Create Review'

      expect(page).to have_css "img[title=#{star_rating_value}]"
      expect(page).to have_content new_text_review.to_s
    end
  end
end
