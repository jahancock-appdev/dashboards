class CurrenciesController < ApplicationController
  def first_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")
    @symbols = @symbols_hash.keys

    render({ :template => "currency_templates/step_one.html.erb"})
  end

end
