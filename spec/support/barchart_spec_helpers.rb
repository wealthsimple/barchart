module Barchart::SpecHelpers
  def barchart_fixture(filename)
    fixture_path = File.expand_path("../../fixtures/#{filename}", __FILE__)
    File.read(fixture_path)
  end

  def barchart_json_fixture(filename)
    string = barchart_fixture(filename)
    hash = JSON.parse(string)
    if hash.is_a?(Array)
      hash.map(&:with_indifferent_access)
    else
      hash.with_indifferent_access
    end
  end
end
