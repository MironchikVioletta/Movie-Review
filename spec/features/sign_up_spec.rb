# frozen_string_literal: true

describe 'the sign up process', type: :feature do
  context 'successful sign up' do
    it do
      visit '/users/sign_up'

      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      fill_in 'Age', with: 20

      click_button 'Sign up'
      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end
  end

  context 'failed sign up' do
    it 'age field is empty' do
      visit '/users/sign_up'

      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'PASSWORD'
      fill_in 'Age', with: 20

      click_button 'Sign up'
      expect(page).to have_content "Password confirmation doesn't match Password"
    end
  end
end
