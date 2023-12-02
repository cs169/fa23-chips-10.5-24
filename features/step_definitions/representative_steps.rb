# frozen_string_literal: true

require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'selectors'))

Given(/^Representative "([^"]*)" exists$/) do |name|
  Representative.where(name: name).first_or_create
end

Given(/^I am logged in$/) do
  User.where(id: 1).first_or_create(provider: 'github', uid: '123')
  page.driver.browser.set_cookie('stub_user_id=1')
end
