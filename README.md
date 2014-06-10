# CucumberTricks

Cucumber step definition dsl extension to easily define more readable steps.

## Installation

Add this line to your application's Gemfile:

    gem 'cucumber_tricks', :require => false

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cucumber_tricks

## Usage

Detailed usage examples can be found on [relish](https://www.relishapp.com/philou/cucumber-tricks/docs)

### Requiring the files

Add `require 'cucumber_tricks' from every steps definition file where you use
it. This will make cucumber work in normal mode as well as in dry-run mode.

### Use pronouns to reference previously introduced items

foo.feature

```gherkin
Given the tool 'screwdriver'
When this tool is used
```

steps.rb

```ruby
A_TOOL = NameOrPronounTransform('tool', 'hammer')

Given /^(#{A_TOOL})$/ do
  ...
end
```

### Use the same step implementation to handle an inline arg as a 1-cell table
### Add default values to the hashes of a table
### Define named lists from a table

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
