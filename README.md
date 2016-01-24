# barchart

Client library for querying barchart.

## Configuration

```json
Barchart.configure do |config|
  config.api_key = 'your_api_key'
  config.api_base_url = 'http://ondemand.websol.barchart.com'
end
```
## Usage

```json
Barchart::Quote.get!('AAPL')
```
