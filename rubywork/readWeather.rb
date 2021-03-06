require 'rubygems'
require 'scrapi'
require 'htmlentities'
require 'tidy'

# 天气预报
class Weather
  
  def self.find(id,force = false)
    puts "id"+id
    # weather = Rails.cache.read("data/weathers/#{id}")
     # weather = []
    # if not weather or force
      weather = self.find_remote(id)
        puts weather
      # Rails.cache.write("data/weathers/#{id}",weather)
    # end
    # weather
  end
  
  #private
  # 从远程抓取天气
  def self.find_remote(id)
    weathers = Scraper.define do
      array :items    
      process "html>body>div:nth-of-type(6)>div>div:nth-of-type(2)>div.tqxq_nr>div.tqyb_new", 
        :items => Scraper.define {
          process "ul.day", :day => :text
          # 白天天气
          process "ul.content2>li:nth-of-type(1)>a", :d_weather => :text
          # 晚上天气
          process "ul.content2>li:nth-of-type(2)>a", :n_weather => :text
          # 白天温度
          process "ul.content3>li:nth-of-type(1)>a>strong", :d_temperature => :text
          # 晚上温度
          process "ul.content3>li:nth-of-type(2)>em>a>strong", :n_temperature => :text
          result :day,:d_weather,:n_weather,:d_temperature,:n_temperature
      }
      result :items
    end
    
    uri = URI.parse("http://www.weather.com.cn/html/weather/#{id}.shtml")
    
    items = weathers.scrape(uri)
    if items.length < 3
      puts "source HTML bad,unable to get weather data."
    end
    
    items = [items[0],items[1],items[2]]
    i = 0
    weather = []
    coder = HTMLEntities.new
    items.each do |w|      
      weather << {
        :date => Date.today + (i),
        :day_weather => coder.decode(w.d_weather),
        :day_temperature => w.d_temperature.to_i,
        :night_weather => coder.decode(w.n_weather),
        :night_temperature => w.n_temperature.to_i
      }
      i += 1
    end    
    weather
  end

end

#http://www.weather.com.cn/html/weather/101270101.shtml



Weather.find('101270101')