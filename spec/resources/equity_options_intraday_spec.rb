require 'pry'

describe Barchart::EquityOptionsIntraday do
  describe ".get!" do
    context "with a valid underlying_symbols" do
      before(:each) do
        stub_request(:get, "http://api_base_url/getEquityOptionsIntraday.json?apikey=secret&fields=bid,ask&underlying_symbols=GOOGL,AAPL")
          .to_return(status: 200, body: barchart_fixture("getEquityOptionsIntraday-valid.json"))
      end

      subject(:equity_options_intradays) { described_class.get!(["GOOGL", "AAPL"], fields: ["bid", "ask"]) }

      it { is_expected.to be_an(Array) }
      its(:size) { is_expected.to eq(2) }

      describe "equity_options_intradays[0]" do
        subject(:googl) { equity_options_intradays[0] }

        its(:underlying_symbol) { is_expected.to eq("GOOGL") }
        its(:symbol) { is_expected.to eq("GOOGL170519P00600000") }
        its(:bid) { is_expected.to eq(0) }
        its(:ask) { is_expected.to eq(0.15) }
      end

      describe "equity_options_intradays[1]" do
        subject(:aapl) { equity_options_intradays[1] }

        its(:underlying_symbol) { is_expected.to eq("AAPL") }
        its(:symbol) { is_expected.to eq("AAPL170519P00002500") }
        its(:bid) { is_expected.to eq(0) }
        its(:ask) { is_expected.to eq(0.02) }
      end
    end

    context "with an invalid symbol" do
      before(:each) do
        stub_request(:get, "http://api_base_url/getEquityOptionsIntraday.json?apikey=secret&fields=bid,ask&underlying_symbols=INVALID")
          .to_return(status: 204, body: barchart_fixture("getEquityOptionsIntraday-invalid.json"))
      end

      subject(:quote) { described_class.get!("INVALID", fields: ["bid", "ask"]) }

      it { is_expected.to be_nil }
    end
  end

  describe "datetime & date fields" do
    subject { FactoryGirl.build(:equity_options_intraday) }

    its(:date) { is_expected.to be_a(DateTime) }
    its(:last_update_date) { is_expected.to be_a(DateTime) }
    its(:expiration_date) { is_expected.to be_a(Date) }
    its(:bid_date) { is_expected.to be_a(Date) }
    its(:ask_date) { is_expected.to be_a(Date) }
    its(:last_trade_date) { is_expected.to be_a(Date) }
  end
end
