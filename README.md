# barchart

Client library for querying barchart.

## Configuration

```ruby
Barchart.configure do |config|
  config.api_key = 'your_api_key'
  config.api_base_url = 'http://ondemand.websol.barchart.com'
end
```
## Usage

```ruby
Barchart::Quote.get!('AAPL')
```
and the output...
```ruby
=> #<Barchart::Quote symbol="AAPL", name="Apple Inc", day_code="L", server_timestamp=nil, mode="r", last_price=101.42, trade_timestamp="2016-01-22T00:00:00-06:00", net_change=5.12, percent_change=5.32, bid=0, ask=0, unit_code="2", open=98.63, high=101.46, low=98.37, close=101.42, num_trades=274569, dollar_volume=5844876768.2, flag="s", volume=65800400, previous_volume=52161398>
```
