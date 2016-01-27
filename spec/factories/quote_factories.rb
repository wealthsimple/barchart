FactoryGirl.define do
  factory :quote, class: Barchart::Quote do
    skip_create

    initialize_with do
      new(JSON.parse(fixture("getQuote-single.json")))
    end

    trait :invalid do
      initialize_with do
        new(JSON.parse(fixture("getQuote-invalid.json")))
      end
    end
  end
end
