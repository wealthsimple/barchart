describe Barchart::History do
  describe ".get!" do
    context "for a single day (markets are open)" do
      before(:each) do
        stub_request(:get, "http://api_base_url/getHistory.json?apikey=secret&endDate=20160125&startDate=20160125&symbol=GOOGL&type=daily")
          .to_return(status: 200, body: barchart_fixture("getHistory-markets-open.json"))
      end

      let(:date) { Date.new(2016, 1, 25) }
      subject(:history) { described_class.get!("GOOGL", date, date) }

      it { is_expected.to be_a(Array) }
      its(:size) { is_expected.to eq(1) }

      describe "history[0]" do
        subject(:googl) { history[0] }

        its(:symbol) { is_expected.to eq("GOOGL") }
        its(:close) { is_expected.to eq(733.62) }
        its(:trading_day) { is_expected.to eq(date) }
      end
    end

    context "for a single day (markets are closed, e.g. weekend)" do
      before(:each) do
        stub_request(:get, "http://api_base_url/getHistory.json?apikey=secret&endDate=20160123&startDate=20160123&symbol=GOOGL&type=daily")
          .to_return(status: 200, body: barchart_fixture("getHistory-markets-closed.json"))
      end

      let(:date) { Date.new(2016, 1, 23) }
      subject(:history) { described_class.get!("GOOGL", date, date) }

      it { is_expected.to be_a(Array) }
      its(:size) { is_expected.to eq(1) }

      describe "history[0]" do
        subject(:googl) { history[0] }

        its(:symbol) { is_expected.to eq("GOOGL") }
        its(:close) { is_expected.to be_nil }
        its(:trading_day) { is_expected.to eq(false) }
      end
    end

    context "for a range of days" do
      before(:each) do
        stub_request(:get, "http://api_base_url/getHistory.json?apikey=secret&endDate=20160125&startDate=20160121&symbol=GOOGL&type=daily")
          .to_return(status: 200, body: barchart_fixture("getHistory-range.json"))
      end

      let(:start_date) { Date.new(2016, 1, 21) }
      let(:end_date) { Date.new(2016, 1, 25) }
      subject(:history) { described_class.get!("GOOGL", start_date, end_date) }

      it { is_expected.to be_a(Array) }
      its(:size) { is_expected.to eq(3) }

      describe "history[0]" do
        subject(:googl) { history[0] }

        its(:symbol) { is_expected.to eq("GOOGL") }
        its(:close) { is_expected.to eq(726.67) }
        its(:trading_day) { is_expected.to eq(Date.new(2016, 1, 21)) }
      end

      describe "history[0]" do
        subject(:googl) { history[1] }

        its(:symbol) { is_expected.to eq("GOOGL") }
        its(:close) { is_expected.to eq(745.46) }
        its(:trading_day) { is_expected.to eq(Date.new(2016, 1, 22)) }
      end

      describe "history[0]" do
        subject(:googl) { history[2] }

        its(:symbol) { is_expected.to eq("GOOGL") }
        its(:close) { is_expected.to eq(733.62) }
        its(:trading_day) { is_expected.to eq(Date.new(2016, 1, 25)) }
      end
    end
  end

  describe "datetime & date fields" do
    subject { FactoryGirl.build(:barchart_history) }

    its(:timestamp) { is_expected.to be_a(DateTime) }
    its(:trading_day) { is_expected.to be_a(Date) }
  end
end
