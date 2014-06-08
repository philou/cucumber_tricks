require 'fileutils'

Given(/^a file named "(.*?)" with$/) do |file_path, content|
  full_path = File.join('tmp', file_path)
  FileUtils.makedirs(File.dirname(full_path))
  IO.write(full_path, content)
end

When(/^I run cucumber "(.*?)"$/) do |args|
  @cucumber_success = system("cucumber tmp/#{args}")
end

Then(/^it should pass$/) do
  expect(@cucumber_success).to be(true), "cucumber sub process failed"
end
