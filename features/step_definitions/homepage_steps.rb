When /^I go to the home page$/ do
  visit('/')
end

Then /^I should see the title$/ do
  page.should have_content('Welcome to Kindling!')
end

Then /^I should see the about section$/ do
  page.should have_content('About')
end

Then /^I should not see the bookshelf section$/ do
  page.should_not have_content('Bookshelf')
end

Given /^I am signed in$/ do
  steps %{
    Given I am a registered user
    When I go to the home page
    And I follow the sign in link
    And I fill out the sign in form
    Then I should be signed in
  }
end

Given /^I have a bunch of books in my bookshelf$/ do
  @books = 10.times.map { |i| Factory.create(:item) }
  @books.each { |book| @user.items << book } 
end

Then /^I should see my bookshelf containing those books$/ do
  @books.each do |book|
    page.should have_content(book.title)
  end
end
