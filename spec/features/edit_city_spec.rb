# frozen_string_literal: true

require 'rails_helper'

describe 'the edit city process', type: :feature do
  include LogInSpecHelper
  let(:new_city_name) { 'Oslo' }

  context 'unregistered user' do
    it 'successfully update city', js: true do
      visit '/'
      expect('#edit-user-city').not_to eq(new_city_name)
      find('#edit-user-city').click
      fill_in 'City', with: new_city_name
      click_button 'Edit City'

      expect(page).to have_content 'City was successfully updated.'
      expect(page).to have_content "Your city is  #{new_city_name}"
    end
  end

  context 'registered user' do
    let(:user) { create(:user) }

    before do
      log_in(user.email, user.password)
    end

    it 'successfully update city' do
      expect('#edit-user-city').not_to eq(new_city_name)
      click_link user.city
      fill_in 'City', with: new_city_name
      click_button 'Edit City'

      expect(page).to have_content 'City was successfully updated.'
      expect(page).to have_content "Your city is  #{new_city_name}"
    end
  end
end
