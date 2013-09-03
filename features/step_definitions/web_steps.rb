Given /^I am on (.+)$/ do |path|
  visit path
end

When /^I go to (.*)$/ do |path|
  visit path
end

When /^I press "(.*)"$/ do |button|
  click_button(button)
end

When /^I follow "(.*)"$/ do |link|
  click_link(link)
end

When /^I click "(.*)"$/ do |link|
  find(link).click
end

When /^I fill in "(.*)" with "(.*)"$/ do |field, value|
  fill_in(field, :with => value)
end

def recurly_fill_in(element, value)
  find(:css, element).set value
end

When /^I fill in recurly First Name with "(.*)"$/ do |value|
  recurly_fill_in "div.first_name:nth-child(1) > input:nth-child(2)", value
end

When /^I fill in recurly Last Name with "(.*)"$/ do |value|
  recurly_fill_in "div.last_name:nth-child(2) > input:nth-child(2)", value
end

When /^I fill in recurly email with "(.*)"$/ do |value|
  recurly_fill_in ".email > input:nth-child(2)", value
end

When /^I fill in recurly Company Name with "(.*)"$/ do |value|
  recurly_fill_in ".company_name > input:nth-child(2)", value
end

When /^I fill in recurly Credit Card Number with "(.*)"$/ do |value|
  recurly_fill_in ".card_number > input:nth-child(2)", value
end

When /^I fill in recurly cvv with "(.*)"$/ do |value|
  recurly_fill_in ".cvv > input:nth-child(2)", value
end

When /^I fill in recurly address1 with "(.*)"$/ do |value|
  recurly_fill_in ".address1 > input:nth-child(2)", value
end

When /^I fill in recurly city with "(.*)"$/ do |value|
  recurly_fill_in ".city > input:nth-child(2)", value
end

When /^I fill in recurly zip with "(.*)"$/ do |value|
  recurly_fill_in ".zip > input:nth-child(2)", value
end

When /^I select "(.*)" from "(.*)"$/ do |value, field|
  select(value, :from => field)
end

When /^I select "(.*)" from recurly state$/ do |field|
  find(:css, ".state > select:nth-child(1)").select field
end

When /^I check "(.*)"$/ do |field|
  check(field)
end

When /^I uncheck "(.*)"$/ do |field|
  uncheck(field)
end

When /^I choose "(.*)"$/ do |field|
  choose(field)
end

Then /^I should see "(.*)"$/ do |text|
  page.should have_content(text)
end

Then /^I should not see "(.*)"$/ do |text|
  page.should_not have_content(text)
end

Then /^the price should be "(.*?)"$/ do |price|
  page.should have_selector("#price")
  current_price = page.find_by_id("price").text
  expect(current_price).to eq(price)
end

Then /^the recurly error message should be "(.*)"$/ do |actual_error|
  recurly_error = find(:css, ".error").text
  expect(recurly_error).to eq(actual_error)
end

require 'net/https'
require 'date'
When /^I sslcheck (.*)$/ do |path|
  uri = URI.parse(path)
  http = Net::HTTP.new(uri.host,uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  http.start do |h|
    @cert = h.peer_cert
  end
end

Then /^the SSL certificate should have at least (\d+) days remaining$/ do |days|
  today = Date.today
  expires = @cert.not_after.to_date

  expect(today).to be < expires
  remaining_days = (expires - today).to_i
  expect(remaining_days).to be > days.to_i
end

When /^I submit the form$/ do
  page.evaluate_script("document.forms[0].submit()")
end

When(/^I look at latest entry date should be no more than (\d+) days old$/) do |days|
  latest_entry = first(:xpath,"//div/div/h3").text
  latest_date = Date.parse(latest_entry)
  today = Date.today
  if latest_date < today
    diff = (today - latest_date).to_i
    expect(diff).to be < days.to_i
  end
end
