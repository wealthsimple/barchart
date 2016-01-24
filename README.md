# barchart

Client library for querying barchart.

# Configuration

```ruby
Barchart.configure do |config|
  config.api_key = 'your_api_key'
  config.api_base_url = 'http://ondemand.websol.barchart.com'
end
```
# Usage

## Quote

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

# Console

This is useful if you just want to try out the package, you'll stil need to initialize Barchart with some valid configuration

```bash
bundle exec ruby Console
```
