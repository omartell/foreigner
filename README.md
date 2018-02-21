# Foreigner

A Ruby library to lookup exchange rates based on the ECB [feed](http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml).

## Usage

### Importing rates
From the source code directory, you can run the included rake task to get the latest rates from ECB:
```
rake foreigner:fetch_ecb_rates
```

Alternatively you can include the rake task in your Rakefile:

```ruby
require 'foreigner/tasks/rake_task'
```

This will store the rates as JSON in `./sources/rates.json` by default.


### Getting exchange rates

Requiring the library:

```ruby
require 'foreigner'
```

Fetching rates in Ruby:
```ruby
Foreigner::Sources::ECB.new.fetch_rates
```

Getting the exchange rate for a particular date:
```ruby
Foreigner::ExchangeRate.at(Date.parse("2018-02-20"), :GBP, :USD) # => 0.1399600762181290264e1
```
The returned value of `ExchangeRate.at` is a [BigDecimal](http://ruby-doc.org/stdlib-2.5.0/libdoc/bigdecimal/rdoc/BigDecimal.html). You can call `to_s("f")` on it if you want a more human readable representation in the console.
```ruby
Foreigner::ExchangeRate.at(Date.parse("2018-02-20"), :GBP, :USD).to_s("f") # => "1.399600762181290264"
```

If there's no exchange rate for the given date the returned value is nil:
```ruby
Foreigner::ExchangeRate.at(Date.parse("2019-02-20"), :GBP, :USD) # => nil
```

If there's also no exchange rate for the given currency the returned value is nil:
```ruby
Foreigner::ExchangeRate.at(Date.parse("2018-02-20"), :GBP, :BTC) # => nil
```

### Configuration

If you want to store the rates file in a different location, you can do the following:

```ruby
Foreigner.configure do |config|
  config.rates_store = "/tmp/rates.json"
end
```

## Tests

Running the tests:

```
bundle exec rspec

```

## Possible Improvements

- `ExchangeRate.at` could return a first class `ExchangeRate` object that encapsulates not just the exchange rate value, but also the currencies that it applies to. However, you would expect this object to behave like a numeric value, so it might be not that straight forward.
