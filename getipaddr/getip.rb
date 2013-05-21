require 'net/http' 
require "uri" 
require 'json'
class Ipdetail
  attr_accessor :start, :send ,:country,:city,:province,:district,:isp
  def initialize()
  
  end
   
  def getByIp(ip)
    sinaURL = "http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js&ip=";


    uri = URI.parse(sinaURL+ip)  
    puts uri.to_s

    response = Net::HTTP.get_response(uri)
    p response.body  
    content = response.body.gsub(/;|var remote_ip_info = /, '')
    h= JSON.parse content
    @start = h["start"]
    @send = h["end"]
    @country = h["country"]
    @province = h["province"]
    @city = h["city"]
    @district = h["district"]
    @isp = h["isp"]
    return to_s
  end
   
  def to_s
    "\"#@start\",\"#@send\",\"#@country\",\"#@province\",\"#@city\",\"#@district\",\"#@isp\""
  end
end

# ipdetail = Ipdetail.new
# 
# p ipdetail.getByIp('124.207.84.210')


require 'rubygems'
# require 'ipparse'

fh = File.new("ip.csv", "w")  #创建一个可写文件流 
File.open('iplist.csv') do |file|
    while line = file.gets
      sleep(1)
       mip = Ipdetail.new.getByIp(line.gsub(/"/, ''))
       fh.puts line.chomp+","+mip
       puts line.chomp+"," + mip
     end
end
fh.close #关闭文件流
