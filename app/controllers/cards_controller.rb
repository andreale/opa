class CardsController < ApplicationController
  layout false

  def erdnuss
    @erdnuss_tag_text = ErdnussScraper.new.get_erdnuss_tag
  end

  def weather
    @weather = WeatherForecaster.new.get_weather
  end

  def foobar
  end
end
