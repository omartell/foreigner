require "foreigner/version"
require "foreigner/config"
require "foreigner/error"
require "foreigner/sources/ecb"
require "foreigner/exchange_rate"
require "foreigner/rates_store"

module Foreigner
  def self.configure
    yield(Config)
  end
end
