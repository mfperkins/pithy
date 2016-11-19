require 'rails_helper'

module FeatureHelpers
  def user_sign_up(email = "test@email.com", password = "password", password_confirmation = "password")
    visit '/users/sign_up'
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password_confirmation
    click_on("Sign up")
  end

  def user_sign_out(email = 'test@email.com')
    visit '/'
    click_on email
    click_on 'sign-out-1'
  end

  def user_sign_in(email = "test@email.com", password = "password")
    visit '/users/sign_in'
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    click_button("Log in")
  end

  def create_quote(name = "Donald Trump", quote = "It's just great. Great.")
    visit '/'
    click_on(name)
    click_on("Add quote")
    fill_in 'quote[text]', with: quote
    click_on("save quote")
  end

  def add_person(first_name = "Winston", last_name = "Churchill", nickname = "Churchill")
    visit '/'
    click_on 'perm_identity'
    fill_in 'person[first_name]', with: first_name
    fill_in 'person[last_name]', with: last_name
    fill_in 'person[nickname]', with: nickname
    click_on "save"
  end

end
