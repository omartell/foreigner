require "yaml"

module Foreigner
  class Config
    class << self
      attr_writer :rates_store

      def sources
        YAML.load_file(File.expand_path("../../../config/sources.yml", __FILE__))
      end

      def rates_store
        @rates_store || File.expand_path("../../../sources/rates.json", __FILE__)
      end
    end
  end
end
