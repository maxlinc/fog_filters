# FogFilters

FogFilters are reusable filters for projects using [VCR](https://github.com/vcr/vcr).

This project is to make it easier to filter out sensitive data or unnecessary interactions (e.g. removing "BUILD" states to speed up tests).  You should still carefully review all your recorded cassettes before pushing to GitHub, to make sure you haven't recorded sensitive or unnecessary data.

## Installation

Add this line to your application's Gemfile:

    gem 'fog_filters'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fog_filters

## Usage

This Gem patches VCR's configuration so it can accept reusable filters.  It is monkeypatched right now, but we will
submit a PR to VCR.

Configure the filters with:
```ruby
VCR.configure do |config|
  config.register_filter(FogFilters::RackspaceConfidential)
  config.register_filter(FogFilters::BuildingServers)
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
