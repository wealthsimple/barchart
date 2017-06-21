FactoryGirl.define do
  factory :equity_options_intraday, class: Barchart::EquityOptionsIntraday do
    skip_create

    initialize_with do
      new(barchart_json_fixture("getEquityOptionsIntraday-valid.json")[:results].first)
    end

    trait :invalid do
      initialize_with do
        new(barchart_json_fixture("getEquityOptionsIntraday-invalid.json")[:results].first)
      end
    end
  end
end
