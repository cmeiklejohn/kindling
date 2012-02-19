Given /^I have some items$/ do
  @user = Factory.create(:item)
end

When /^I view my items$/ do
  click_link('My Items')
end

Given /^I am a signed in registered user$/ do
  steps %{
    Given I am a registered user
    When I go to the home page
    And I follow the sign in link
    And I fill out the sign in form
    Then I should be signed in
  }
end
