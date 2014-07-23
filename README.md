# Shade

Rubygem to find the closest color from a given palette.

[![Build Status](https://api.travis-ci.org/mceachen/shade.png?branch=master)](https://travis-ci.org/mceachen/shade)
[![Gem Version](https://badge.fury.io/rb/shade.png)](http://rubygems.org/gems/shade)
[![Code Climate](https://codeclimate.com/github/mceachen/shade.png)](https://codeclimate.com/github/mceachen/shade)
[![Dependency Status](https://gemnasium.com/mceachen/shade.png)](https://gemnasium.com/mceachen/shade)

This was created to help migrate Twitter's Advertising webapp from more than a thousand
different colors into a small well-considered palette of colors. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shade'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shade

## Usage

```ruby
p = Shade::Palette.new do |p|
  p.add('#663399', 'deepPurple')
  p.add('#5BA636', 'darkGreen')
end

p.nearest_value('green')
=> #<struct Shade::Palette::Value name="#5BA636", css_color="darkGreen">
```

## Contributing

1. Fork it ( https://github.com/mceachen/shade/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
