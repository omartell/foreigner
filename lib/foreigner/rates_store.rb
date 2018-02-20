require "bigdecimal"

module Foreigner
  class RatesStore
    class << self
      def rate_for(currency, date)
        return BigDecimal("1") if currency.to_s == rates.fetch("base_currency")

        rate_string = rates[date.to_s]&.fetch(currency.to_s, nil)

        BigDecimal(rate_string) if rate_string
      end

      def initialize_rates!
        fail Error::RatesFileMissingError unless File.exist?(Foreigner::Config.rates_store)

        JSON.parse(File.read(Foreigner::Config.rates_store))
      end

      def rates
        @rates ||= initialize_rates!
      end
    end
  end
end
