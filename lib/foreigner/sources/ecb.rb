require "net/http"
require "nokogiri"
require "json"
require "rest-client"

module Foreigner
  module Sources
    class ECB
      attr_reader :url
      BASE_CURRENCY = "EUR"

      def initialize(url: nil)
        @url = url || Config.sources.fetch(:ecb)
      end

      def fetch_rates
        document = fetch_document

        date_rates_kv = build_date_rates_kv(document)

        fail Foreigner::Error::RatesNotAvailableError if date_rates_kv.empty?

        write_json_file(date_rates_kv)
      end

      private

      def fetch_document
        Nokogiri::XML(
          RestClient.get(url, { accept: "text/xml", timeout: 5 }).body
        )
      end

      def build_date_rates_kv(document)
        document.css("Cube[time]").map do |node|
          rates = node.css("Cube").map do |child|
            [child["currency"], child["rate"]]
          end.to_h

          [node["time"], rates]
        end.to_h
      end

      def write_json_file(rates)
        File.write(Config.rates_store, JSON.generate(
          rates.merge(base_currency: BASE_CURRENCY))
        )
      end
    end
  end
end
