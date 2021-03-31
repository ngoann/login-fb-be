# frozen_string_literal: true

class FaradayService
  class << self
    def get(url, params = {})
      conn = Faraday.new do |f|
        f.response :raise_error
      end

      conn.get url, params
    end
  end
end
