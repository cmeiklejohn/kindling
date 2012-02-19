When /^I go to the home page$/ do
  visit('/')
end

Then /^I should see the title$/ do
  page.should have_content('Kindling')
end

When /^I follow the sign up link$/ do
  click_link 'Sign Up'
end

When /^I fill out the sign up form$/ do
  @email    = 'christopher.meiklejohn@gmail.com'
  @password = '12345678'

  fill_in 'Email', :with => @email
  fill_in 'Password', :with => @password
  fill_in 'Password confirmation', :with => @password

  click_on 'Sign up'
end

Then /^I should be signed up$/ do
  User.find_by_email(@email).should_not be_nil
  
  page.should have_content('Welcome! You have signed up successfully.')
end

Then /^I should be logged in$/ do
  page.should have_content('Sign Out')
end

Then /^I should be signed in$/ do
  page.should have_content('Signed in successfully.')
  page.should have_content('Sign Out')
end

Then /^I should be signed out$/ do
  page.should have_content('Signed out successfully.')
end

When /^I follow the sign in link$/ do
  click_link 'Sign In'
end

When /^I fill out the sign in form$/ do
  fill_in 'Email', :with => @email
  fill_in 'Password', :with => @password

  click_on 'Sign in'
end

When /^I follow the sign out link$/ do
  click_link 'Sign Out'
end

Given /^I am a registered user$/ do
  @email    = 'christopher.meiklejohn@gmail.com'
  @password = '12345678'
  @user     = Factory(:user, :email => @email, :password => @password)
end
