require 'net/http'
require 'json'
class HomeController < ApplicationController
    # USD-BRL
    # EUR-BRL
    # BTC-BRL
    CURRENCIES = [
        {code: 'USD-BRL'},
        {code: 'EUR-BRL'},
        {code: 'BTC-BRL'}
    ]

    def index
        @chart_data = []
        

        CURRENCIES.each do |currency|
            url = URI("https://economia.awesomeapi.com.br/json/daily/#{currency[:code]}/30")
            response = Net::HTTP.get(url)

            data = JSON.parse(response)

            hash = {}
            data.each do |entry|
                date = Time.at(entry['timestamp'].to_i).strftime("%d-%m-%Y")
                rate = entry['high']

                hash[date] = rate
            end

            @chart_data << {data: hash}
        end
    end
end
