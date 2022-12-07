require 'net/http'

class WeatherForecaster
  API_URL   = 'http://fcc-weather-api.glitch.me/api/current?lat=47&lon=8'

  def get_weather
    # {:coord=>{:lon=>8, :lat=>47}, :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"https://cdn.glitch.com/6e8889e5-7a72-48f0-a061-863548450de5%2F04d.png?1499366020964"}], :base=>"stations", :main=>{:temp=>0.65, :feels_like=>-2.23, :temp_min=>-3, :temp_max=>6.67, :pressure=>1029, :humidity=>86}, :wind=>{:speed=>1}, :clouds=>{:all=>90}, :dt=>1579780495, :sys=>{:type=>1, :id=>6930, :country=>"CH", :sunrise=>1579763015, :sunset=>1579796125}, :timezone=>3600, :id=>2658434, :name=>"Switzerland", :cod=>200}
    {
      image:            weather[:weather].first[:icon],
      status:           weather[:weather].first[:main],
      temp_current:     weather[:main][:temp],
      temp_feels_like:  weather[:main][:feels_like],
      temp_min:         weather[:main][:temp_min],
      temp_max:         weather[:main][:temp_max],
    }
  end

  private

  def weather

    @weather ||= begin
      uri = URI.parse(API_URL)
      proxy_uri = URI.parse(ENV['http_proxy']) rescue nil
      Net::HTTP.start(uri.host, uri.port, (proxy_uri.host rescue nil), (proxy_uri.port rescue nil), 'proxy_user', 'proxy_pass') do |http|
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)
        JSON.parse(response.body).deep_symbolize_keys
      end
    end
  end
end
