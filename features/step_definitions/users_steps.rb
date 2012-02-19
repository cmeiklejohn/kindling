When /^I visit the user page$/ do
  visit user_path(@user)
end

Then /^I should see the users info$/ do
  page.should have_content(@user.email)
end
