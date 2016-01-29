FactoryGirl.define do
  factory :barchart_quote, class: Barchart::Quote do
    skip_create

    initialize_with do
      new(barchart_json_fixture("getQuote-single.json")[:results].first)
    end

    trait :invalid do
      initialize_with do
        new(barchart_json_fixture("getQuote-invalid.json")[:results].first)
      end
    end
  end
end
