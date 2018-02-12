require "foreigner/version"
require "foreigner/config"
require "foreigner/error"
require "foreigner/sources/ecb"

module Foreigner
  def self.configure
    yield(Config)
  end
end
