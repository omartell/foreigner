module Foreigner
  class Error < RuntimeError
    class RatesNotAvailableError < Error; end
    class RatesFileMissingError < Error; end
  end
end
