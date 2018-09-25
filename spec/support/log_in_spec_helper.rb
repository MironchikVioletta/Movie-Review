# frozen_string_literal: true

module LogInSpecHelper
  def log_in(email, password)
    visit '/users/sign_in'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end
end
