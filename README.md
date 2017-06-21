# barchart [![Circle CI](https://circleci.com/gh/wealthsimple/barchart.svg?style=svg)](https://circleci.com/gh/wealthsimple/barchart)

Ruby client library for querying some of [Barchart OnDemand's](http://www.barchartondemand.com/) APIs. They have excellent documentation of their APIs [here](http://www.barchartondemand.com/api.php).  Usage of their APIs requires a paid-subscription.

# Installation

```bash
gem install barchart
```

or add to your Gemfile:

```ruby
gem 'barchart'
```

# Configuration

```ruby
Barchart.configure do |config|
  config.api_key = 'your_api_key'
  config.api_base_url = 'http://ondemand.websol.barchart.com'
end
```

You can optionally override the logger with:

```ruby
# Use the Rails logger:
Barchart.logger = Rails.logger

# If you don't want to output any logs (e.g. in tests):
Barchart.logger = Logger.new(nil)
```

# Usage

## Barchart::Quote

```ruby
Barchart::Quote.get!('AAPL')
```
and the output...
```ruby
=> #<Barchart::Quote symbol="AAPL", name="Apple Inc", day_code="L", server_timestamp=nil, mode="r", last_price=101.42, trade_timestamp="2016-01-22T00:00:00-06:00", net_change=5.12, percent_change=5.32, bid=0, ask=0, unit_code="2", open=98.63, high=101.46, low=98.37, close=101.42, num_trades=274569, dollar_volume=5844876768.2, flag="s", volume=65800400, previous_volume=52161398>
```

You can also provide an array of symbols if you like:

```ruby
Barchart::Quote.get!(['AAPL', 'FB', 'GOOG'])
```

and you'll get an array of `Barchart::Quote`

```ruby
=> [#<Barchart::Quote symbol="AAPL", name="Apple Inc", day_code="L", server_timestamp=nil, mode="r", last_price=101.42, trade_timestamp="2016-01-22T00:00:00-06:00", net_change=5.12, percent_change=5.32, bid=0, ask=0, unit_code="2", open=98.63, high=101.46, low=98.37, close=101.42, num_trades=274569, dollar_volume=5844876768.2, flag="s", volume=65800400, previous_volume=52161398>,
 #<Barchart::Quote symbol="FB", name="Facebook Inc", day_code="L", server_timestamp=nil, mode="r", last_price=97.94, trade_timestamp="2016-01-22T00:00:00-06:00", net_change=3.78, percent_change=4.01, bid=0, ask=0, unit_code="2", open=96.41, high=98.07, low=95.49, close=97.94, num_trades=127919, dollar_volume=2664720705.58, flag="s", volume=30495300, previous_volume=30518898>,
 #<Barchart::Quote symbol="GOOG", name="Alphabet Inc Class C", day_code="L", server_timestamp=nil, mode="r", last_price=725.25, trade_timestamp="2016-01-22T00:00:00-06:00", net_change=18.66, percent_change=2.64, bid=0, ask=0, unit_code="2", open=723.6, high=728.13, low=720.12, close=725.25, num_trades=9735, dollar_volume=982119017.648, flag="s", volume=2011700, previous_volume=2412200>]
 ```

## Barchart::History

Returns historical quotes for equities, indices, and forex.  Specifying `endDate` is optional, defaults to `nil`.

```ruby
Barchart::History.get!('AAPL', 1.week.ago)
```

and you'll get the daily history, an array of `Barchart::History` objects


```ruby
=> [#<Barchart::History symbol="AAPL", timestamp="2016-01-19T00:00:00-05:00", trading_day="2016-01-19", open=98.41, high=98.65, low=95.5, close=96.66, volume=53087700, open_interest=nil>,
#<Barchart::History symbol="AAPL", timestamp="2016-01-20T00:00:00-05:00", trading_day="2016-01-20", open=95.1, high=98.19, low=93.42, close=96.79, volume=72334400, open_interest=nil>,
#<Barchart::History symbol="AAPL", timestamp="2016-01-21T00:00:00-05:00", trading_day="2016-01-21", open=97.06, high=97.88, low=94.94, close=96.3, volume=52161400, open_interest=nil>,
#<Barchart::History symbol="AAPL", timestamp="2016-01-22T00:00:00-05:00", trading_day="2016-01-22", open=98.63, high=101.46, low=98.37, close=101.42, volume=65800400, open_interest=nil>]
```

## Barchart::EquityOptionsIntraday

Returns intraday options data such as strike, expiration date, volatility, etc.

Required arguments:
* underlying_symbols - Array or String

Optional arguments:
* options - Hash
    * fields - Array
    * type - String
    * strike_price - Float
    * expiration_month - String
    * expiration_date - Date
    * only_strikes - Boolean
```ruby
Barchart::EquityOptionsIntraday.get!('AAPL')
```

and you'll get the intraday equity options, an array of `Barchart::EquityOptionsIntraday` objects

```ruby
=> [#<Barchart::EquityOptionsIntraday underlying_symbol="AAPL", symbol="AAPL170519P00002500", exchange="NASDAQ", type="Put", strike=2.5, expiration_date="2017-05-19", expiration_type="monthly", date="2017-05-18", open=0, high=0.02, low=0.02, last=0.02, change=0.02, percent_change=0, volume="2">,
 #<Barchart::EquityOptionsIntraday underlying_symbol="AAPL", symbol="AAPL170519P00005000", exchange="NASDAQ", type="Put", strike=5, expiration_date="2017-05-19", expiration_type="monthly", date="2017-05-18", open=0, high=0.02, low=0.02, last=0.02, change=0.02, percent_change=0, volume="1">,
 #<Barchart::EquityOptionsIntraday underlying_symbol="AAPL", symbol="AAPL170519P00007500", exchange="NASDAQ", type="Put", strike=7.5, expiration_date="2017-05-19", expiration_type="monthly", date="2017-05-18", open=0, high=0, low=0, last=0, change=0, percent_change=nil, volume="0">]
```

# Interactive Console

This is useful if you just want to try out the package, you'll stil need to initialize Barchart with some valid configuration

```bash
bin/console
```

# Reusable factories and fixtures

The barchart gem provides reusable [factory_girl](https://github.com/thoughtbot/factory_girl) factories and JSON fixtures.

To include these in your own project, add the following to `spec/spec_helper.rb`:

```ruby
require 'factory_girl'
barchart_dir = Gem::Specification.find_by_name("barchart").gem_dir
Dir.glob([
  File.join(barchart_dir, "spec/support/*.rb"),
  File.join(barchart_dir, "spec/factories/*.rb"),
]).each { |f| require(f) }

RSpec.configure do |config|
  include Barchart::SpecHelpers
  # Other configuration goes here
end
```
