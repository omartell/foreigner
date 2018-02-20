module Foreigner
  class ExchangeRate
    class << self
      def at(date, from_currency, to_currency)
        return if !rate_for(from_currency, date) || !rate_for(to_currency, date)

        BigDecimal("1") * rate_for(to_currency, date) / rate_for(from_currency, date)
      end

      def rate_for(currency, date)
        return BigDecimal("1") if currency.to_s == "EUR"

        rate_string = rates[date.to_s]&.fetch(currency.to_s, nil)

        BigDecimal(rate_string) if rate_string
      end

      def rates
        JSON.parse(File.read(Foreigner::Config.rates_store))
      end
    end
  end
end
