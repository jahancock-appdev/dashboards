class CurrenciesController < ApplicationController
  def first_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")
    @symbols = @symbols_hash.keys

    render({ :template => "currency_templates/step_one.html.erb"})
  end

  def second_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")
    @symbols = @symbols_hash.keys

    @first_currency = params.fetch("first_currency")

    render({ :template => "currency_templates/step_two.html.erb"})
  end
  
  def exchange_rate
    @first_currency = params.fetch("first_currency")
    @second_currency = params.fetch("second_currency")
    xr_link = "https://api.exchangerate.host/convert?from=" + @first_currency + "&to=" + @second_currency
    @raw_data = open(xr_link).read
    @parsed_data = JSON.parse(@raw_data)

    @xr = @parsed_data.fetch("info").fetch("rate")
    render({  :template => "currency_templates/step_three.html.erb"})
  end

end
