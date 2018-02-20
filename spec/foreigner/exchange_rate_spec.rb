require "spec_helper"

RSpec.describe Foreigner::ExchangeRate do
  before do
    ecb = Foreigner::Sources::ECB.new
    ecb.fetch_rates
  end

  describe ".at" do
    context "when both currencies are the same" do
      it "returns one as the exchange rate" do
        expect(
          described_class.at(Date.parse("2018-02-09"), :GBP, :GBP)
        ).to eq(BigDecimal("1"))
      end
    end

    context "when the from currency is equal to the base currency" do
      it "returns the exchange rate for the given currencies" do
        expect(
          described_class.at(Date.parse("2018-02-09"), :EUR, :GBP)
        ).to eq(BigDecimal("0.8874"))
      end
    end

    context "when the to currency is equal to the base currency" do
      it "returns the exchange rate for the given currencies" do
        expect(
          described_class.at(Date.parse("2018-02-09"), :GBP, :EUR)
        ).to eq(1 / BigDecimal("0.8874"))
      end
    end

    context "when the from and to currency are not equal to the base currency" do
      it "returns the exchange rate for the given currencies" do
        expect(
          described_class.at(Date.parse("2018-02-09"), :GBP, :USD)
        ).to eq(BigDecimal("1") * BigDecimal("1.2273") / BigDecimal("0.8874"))
      end
    end

    context "when there's no exchange rate for the given date" do
      it "returns nil" do
        expect(
          described_class.at(Date.today, :EUR, :GBP)
        ).to be_nil
      end
    end

    context "when the from currency is unknown" do
      it "returns nil" do
        expect(
          described_class.at(Date.parse("2018-02-09"), :BTC, :EUR)
        ).to be_nil
      end
    end

    context "when the to currency is unknown" do
      it "returns nil" do
        expect(
          described_class.at(Date.parse("2018-02-09"), :EUR, :BTC)
        ).to be_nil
      end
    end
  end
end
