describe Barchart::Quote do
  describe ".get!" do
    context "with one symbol" do
      before(:each) do
        stub_request(:get, "http://api_base_url/getQuote.json?apikey=secret&fields=bid,ask&symbols=GOOGL")
          .to_return(status: 200, body: fixture("getQuote-single.json"))
      end

      subject(:quote) { described_class.get!("GOOGL") }

      it { is_expected.to be_a(Barchart::Quote) }
      its(:symbol) { is_expected.to eq("GOOGL") }
      its(:name) { is_expected.to eq("Alphabet Inc") }
      its(:last_price) { is_expected.to eq(733.79) }
    end

    context "with an array of symbols" do
      before(:each) do
        stub_request(:get, "http://api_base_url/getQuote.json?apikey=secret&fields=bid,ask&symbols=GOOGL,CBO.TO")
          .to_return(status: 200, body: fixture("getQuote-multiple.json"))
      end

      subject(:quotes) { described_class.get!(["GOOGL", "CBO.TO"]) }

      it { is_expected.to be_an(Array) }
      its(:size) { is_expected.to eq(2) }

      describe "quotes[0]" do
        subject(:googl) { quotes[0] }

        it { is_expected.to be_a(Barchart::Quote) }
        its(:symbol) { is_expected.to eq("GOOGL") }
        its(:name) { is_expected.to eq("Alphabet Inc") }
        its(:last_price) { is_expected.to eq(733.79) }
      end

      describe "quotes[1]" do
        subject(:aapl) { quotes[1] }

        it { is_expected.to be_a(Barchart::Quote) }
        its(:symbol) { is_expected.to eq("CBO.TO") }
        its(:name) { is_expected.to eq("Ishares 1-5Yr Laddered C") }
        its(:last_price) { is_expected.to eq(19.09) }
      end
    end

    context "with an invalid symbol" do
      before(:each) do
        stub_request(:get, "http://api_base_url/getQuote.json?apikey=secret&fields=bid,ask&symbols=INVALID")
          .to_return(status: 204, body: fixture("getQuote-invalid.json"))
      end

      subject(:quote) { described_class.get!("INVALID") }

      it { is_expected.to be_nil }
    end
  end

  describe "datetime fields" do
    subject { FactoryGirl.build(:barchart_quote) }

    its(:server_timestamp) { is_expected.to be_a(DateTime) }
    its(:trade_timestamp) { is_expected.to be_a(DateTime) }
  end
end
