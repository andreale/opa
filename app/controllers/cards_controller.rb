class CardsController < ApplicationController
  layout false

  def erdnuss
    @erdnuss_tag_text = ErdnussScraper.new.get_erdnuss_tag
  end

  def well_com
    @well_com_menu = WellComScraper.new.get_well_com_menu
  end

  def weather
    @weather = WeatherForecaster.new.get_weather
  end
end
