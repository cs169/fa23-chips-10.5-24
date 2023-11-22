# frozen_string_literal: true

require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'selectors'))

def expect_display_type(display_type, name)
  expect(page).to have_css("path[data-#{display_type}-name=\"#{name}\"]")
end

When /^(?:|I )click on the (state|county) "([^"]*)"$/ do |display_type, name|
  expect_display_type(display_type, name)
  find("path[data-#{display_type}-name=\"#{name}\"]").click
end

Then /^(?:|I )can see a (state|county) such as "([^"]*)"$/ do |display_type, name|
  expect_display_type(display_type, name)
end

Given /^(?:|I )can see at least one state$/ do
  expect(page).to have_css('path')
end

Then /^the map should zoom in on "([^"]*)"$/ do |state|
  expect(page).to have_css('h2', text: state, wait: 5)
end
