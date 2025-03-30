require 'net/http'
require 'json'
class HomeController < ApplicationController
    # USD-BRL
    # EUR-BRL
    # BTC-BRL

    def index
        @chart_data = ({"2025-01-01" => 2, "2025-01-02" => 3}) 

        url = URI("https://economia.awesomeapi.com.br/json/daily/USD-BRL/30")
        response = Net::HTTP.get(url)

        data = JSON.parse(response)

        hash = {}
        data.each do |entry|
            date = Time.at(entry['timestamp'].to_i).strftime("%d-%m-%Y")
            rate = entry['high']

            hash[date] = rate
        end

        @chart_data = hash
    end
end
