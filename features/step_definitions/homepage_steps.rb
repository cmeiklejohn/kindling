When /^I go to the home page$/ do
  visit('/')
end

Then /^I should see the title$/ do
  page.should have_content('Kindling')
end
