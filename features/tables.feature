Feature: Special tables

  As a feature writer
  In order to have more readable scenarios
  I want to be able to use different forms of data tables

  Scenario: Hashes with extra values

    It is possible to simply extend all hashes from a scenario table with
    default values. As scenario given values override the default, it is
    possible to specify more or less columns in different scenarios, while
    using the same step defintion.

    Given a file named "features/step_definitions/steps.rb" with
"""
require 'cucumber_tricks'

Given(/^the fishes$/) do |table|
  @hashes = table.hashes_with_defaults('name', 'size' => 'normal')
end

Then(/^(.*) should be (.*) and have a (.*) size$/) do |name, color, size|
  @hashes.select { |fish| fish['name'] == name }.each do |fish|
    expect(fish['color']).to eq(color)
    expect(fish['size']).to eq(size)
  end
end

"""
    And a file named "features/foo.feature" with
"""
Feature:
  Scenario:
    Given the fishes
      | name   | color |
      | Whity  | white |
      | Blacky | black |
      | Reddy  | red   |
    Then Whity should be white and have a normal size
    And Blacky should be black and have a normal size
    And Reddy should be red and have a normal size
"""
    When I run cucumber "features/foo.feature"
    Then it should pass

  Scenario: Default hashes with a one column raw table

    For readability reasons, With a one column table it is possible to omit the
    name of that column from the scenario.

    Given a file named "features/step_definitions/steps.rb" with
"""
require 'cucumber_tricks'

Given(/^the fishes$/) do |names|
  @hashes = names.hashes_with_defaults('name', 'size' => 'normal')
end

Then(/^(.*) should have a (.*) size$/) do |name, size|
  @hashes.select { |fish| fish['name'] == name }.each do |fish|
    expect(fish['size']).to eq(size)
  end
end

"""
    And a file named "features/foo.feature" with
"""
Feature:
  Scenario:
    Given the fishes
      | Whity  |
      | Reddy  |
    Then Whity should have a normal size
    And Reddy should have a normal size
"""
    When I run cucumber "features/foo.feature"
    Then it should pass

  Scenario: Tables to named lists

    Using the '=>' notation in a scenario data table, one can define a set of
    named lists.

    Given a file named "features/step_definitions/steps.rb" with
"""
require 'cucumber_tricks'

Given(/^the dishes$/) do |dishes|
  @dishes = dishes.hash_2_lists
end

Then(/^(.*) should be made of$/) do |dish, table|
  ingredients = table.raw.map {|row| row.first}

  expect(@dishes[dish]).to eq(ingredients)
end

"""
    And a file named "features/foo.feature" with
"""
Feature:
  Scenario:
    Given the dishes
      | Burger               | => | Bread     | Meat             | Ketchup |
      | Spaghetti Bolognaise | => | Spaghetti | Bolognaise sauce |         |
    Then Burger should be made of
      | Bread   |
      | Meat    |
      | Ketchup |
    And Spaghetti Bolognaise should be made of
      | Spaghetti        |
      | Bolognaise sauce |
"""
    When I run cucumber "features/foo.feature"
    Then it should pass
