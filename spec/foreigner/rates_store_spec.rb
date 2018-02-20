require "spec_helper"

RSpec.describe Foreigner::RatesStore do
  before do
    ecb = Foreigner::Sources::ECB.new
    ecb.fetch_rates
  end

  describe ".rate_for" do
    context "when there are no rates for the given date" do
      it "returns nil" do
        expect(
          described_class.rate_for(:GBP, Date.today)
        ).to be_nil
      end
    end

    context "when there are no rates for the given currency " do
      it "returns nil" do
        expect(
          described_class.rate_for(:BTC, Date.parse("2018-02-09"))
        ).to be_nil
      end
    end

    context "when the currency is the base currency" do
      it "returns the exchange rate for the given currency and date" do
        expect(
          described_class.rate_for(:EUR, Date.parse("2018-02-09"))
        ).to eq(BigDecimal("1"))
      end
    end

    context "when the currency is not the base currency" do
      it "returns the exchange rate for the given currency and date" do
        expect(
          described_class.rate_for(:GBP, Date.parse("2018-02-09"))
        ).to eq(BigDecimal("0.8874"))
      end
    end
  end
end
