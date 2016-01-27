FactoryGirl.define do
  factory :barchart_history, class: Barchart::History do
    skip_create

    initialize_with do
      new(json_fixture("getHistory-markets-open.json")[:results].first)
    end

    trait :markets_closed do
      initialize_with do
        new(json_fixture("getHistory-markets-closed.json")[:results].first)
      end
    end
  end
end
