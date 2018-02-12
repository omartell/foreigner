module Foreigner
  class Error < RuntimeError
    class RatesNotAvailableError < Error; end
  end
end
