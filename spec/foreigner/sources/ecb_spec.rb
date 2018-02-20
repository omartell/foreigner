require "spec_helper"

RSpec.describe Foreigner::Sources::ECB do
  let(:ecb) { described_class.new }

  def empty_fixture_xml
    File.read(File.expand_path("../../../fixtures/empty.xml", __FILE__))
  end

  def rates_json_file
    JSON.parse(File.read(Foreigner::Config.rates_store))
  end

  describe "#fetch_rates" do
    it "outputs the ECB rates into a JSON file with the dates as keys and the rates for that date as values" do
      ecb.fetch_rates

      expect(rates_json_file).to match(hash_including(
        "2018-02-09" => hash_including(
          "USD" => "1.2273",
          "GBP" => "0.8874"
        ),
        "2018-02-08" => hash_including(
          "JPY" => "134.31",
          "GBP" => "0.87513"
        ),
        "2018-02-07" => hash_including(
          "GBP" => "0.88675",
          "DKK" => "7.443"),
      ))
    end

    it "raises an error if it's not able to generate the JSON file with the rates" do
      stub_request(:get, /www.ecb.europa.eu/).to_return(body: empty_fixture_xml)

      expect {
        ecb.fetch_rates
      }.to raise_error(Foreigner::Error::RatesNotAvailableError)
    end
  end
end
