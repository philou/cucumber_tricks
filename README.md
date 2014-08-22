[![Build Status](https://travis-ci.org/philou/cucumber_tricks.svg?branch=master)](https://travis-ci.org/philou/cucumber_tricks) [![Test Coverage](https://codeclimate.com/github/philou/cucumber_tricks/badges/coverage.svg)](https://codeclimate.com/github/philou/cucumber_tricks) [![Code Climate](https://codeclimate.com/github/philou/cucumber_tricks/badges/gpa.svg)](https://codeclimate.com/github/philou/cucumber_tricks)

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

Given /^(#{A_TOOL})$/ do |tool|
  ...
end
```

### Use the same step implementation to handle an inline arg as a 1-cell table

steps.rb

```ruby
GivenEither /^the dog named "(.*)"$)$/,
            /^the following dogs$/ do |dogs_table|
  ...
end
```

foo.feature

```gherkin
Given the dog "Rolphy"
...
Given the following dogs
  | Rex  |
  | King |
  | Volt |
```

### Add default values to the hashes of a table

foo.feature

```gherkin
Given the following dogs
  | names | color |
  | Rex   | white |
  | King  | Sand  |
```

steps.rb

```ruby
Given /^the following dogs$$/ do |dogs|
  hashes = dogs.hashes_with_defaults('names', 'tail' => 'wagging', 'smell' => 'not nice')

#  hashes.each do |hash|
#    expect(hash['smell']).to eq('not nice')
#  end

  ...
end
```

### Define named lists from a table

foo.feature

```gherkin
Given the following dishes
  | Spaghetti Bolognaise | => | Spaghetti | Bolognaise sauce |       |         |
  | Burger               | => | Bread     | Meat             | Salad | Ketchup |
```

steps.rb

```ruby
Given /^the following dishes$$/ do |dishes|
  name_2_dishes = dishes.hash_2_lists

#  expect(name_2_dishes['Burger']).to eq(['Bread','Meat','Salad','Ketchup'])

  ...
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
