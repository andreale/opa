class CardsController < ApplicationController
  def index
    @erdnuss_tag_text = ErdnussScraper.new.get_erdnuss_tag
    @well_com_menu = WellComScraper.new.get_well_com_menu
    @weather = WeatherForecaster.new.get_weather
  end
end
