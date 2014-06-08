Feature: Either

  As a developper tester
  In order to factorize code and support english readable steps
  I want a one liner to define a step that can take either a 1-cell table or a string

  Background: Step defintions

    Given a file named "features/step_definitions/steps.rb" with
"""
require 'cucumber_tricks'

GivenEither /^the dish with "(.*)"$/,
            /^the dish with the following ingredients$/ do |ingredients|
  @ingredients = ingredients
end

Then /^the dish should contain$/ do |ingredients|
  expect(@ingredients.raw).to eq(ingredients.raw)
end

"""

  Scenario: The inline step definition

    The inline regex transforms it's argument to a 1-cell raw table

    Given a file named "features/foo.feature" with
"""
Feature:
  Scenario:
    Given the dish with "peanuts"
    Then the dish should contain
      | peanuts |
"""
    When I run cucumber "features/foo.feature"
    Then it should pass

  Scenario: The table step definition

    The table step definition is as any table step definitions.

    Given a file named "features/foo.feature" with
"""
Feature:
  Scenario:
    Given the dish with the following ingredients
      | pasta    |
      | tomatoes |
    Then the dish should contain
      | pasta    |
      | tomatoes |
"""
    When I run cucumber "features/foo.feature"
    Then it should pass

  Scenario: With When and Then

    This also works for 'When' and 'Then'

    Given a file named "features/step_definitions/steps.rb" with
"""
require 'cucumber_tricks'

WhenEither /^the dish contains "(.*)"$/,
           /^the dish contains the following ingredients$/ do |ingredients|
  @ingredients = ingredients
end

ThenEither /^the dish should contain "(.*)"$/,
           /^the dish should contain$/ do |ingredients|
  expect(@ingredients.raw).to eq(ingredients.raw)
end

"""
    And a file named "features/foo.feature" with
"""
Feature:
  Scenario:
    When the dish contains "peanuts"
    Then the dish should contain
      | peanuts |
"""
    When I run cucumber "features/foo.feature"
    Then it should pass
