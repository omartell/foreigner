module Foreigner
  class ExchangeRate
    def self.at(date, from_currency, to_currency)
      return if !RatesStore.rate_for(from_currency, date) || !RatesStore.rate_for(to_currency, date)

      RatesStore.rate_for(to_currency, date) / RatesStore.rate_for(from_currency, date)
    end
  end
end
