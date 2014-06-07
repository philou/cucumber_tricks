Feature: Pronouns

  As a developper tester
  In order to be factorize code and support english readable steps
  I want a special textual transform that can be referenced with a pronoun

  Special NameOrPronounTransform creates special transform that can have a default
  value.

  Background: Step definitions

    Given a file named "features/step_definitions/step.rb" with
"""
require 'cucumber_tricks'

A_TOOL = NameOrPronounTransform('tool','hammer')

Given /^(#{A_TOOL})$/ do |tool|
end

Then /^(#{A_TOOL}) should be a "(.*)"$/ do |tool, expected|
  expect(tool).to eq(expected)
end
"""

  Scenario Outline: Referencing a previously declared thing

    After the first usage of the transform in the scenario, later steps can
    then use it without repeating its name.

    For readability reason, it is possible to reference this value using many
    different pronouns.

    Given a file named "features/foo.feature" with
"""
Feature:
  Scenario:
    Given the tool "screwdriver"
    Then <this> tool should be a "screwdriver"
"""

    When I run cucumber "features/foo.feature"
    Then it should pass

  Examples:
    | this |
    | this |
    | a    |
    | an   |
    | the  |
    | of   |

  Scenario: Default value for a thing

    If no value is specified at the first usage of a transform in a scenario
    it automaticaly gets the value specified in the transform definition.

    Given a file named "features/foo.feature" with
"""
Feature:
  Scenario:
    Then the tool should be a "hammer"
"""

    When I run cucumber "features/foo.feature"
    Then it should pass

