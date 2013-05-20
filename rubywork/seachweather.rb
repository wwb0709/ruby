# encoding: utf-8
require 'rubygems'    
require 'nokogiri'    
require 'open-uri'  
load '/Users/wwb/Desktop/ruby/rubywork/mymail.rb'  
# url = "http://code4app.com/category/gesture"  
# doc = Nokogiri::HTML(open(url))  
# puts doc.at_css("title").text 
# doc.css("#categorybox").each do |c|  
#   puts c.content 
# end  

url2 = "http://www.weather.com.cn/weather/101010100.shtml"  
doc2 = Nokogiri::HTML(open(url2))  
# doc2.css('#weather6h').each_with_index do |link,index|
#   puts '*'*40
#   puts "#{link.content}"
#   
# end



class Weather
  attr_accessor :shijianduan, :tianqi ,:wendu,:fengji
  def initialize(shijianduan='', tianqi='',wendu='',fengji='')
    @shijianduan, @tianqi, @wendu, @fengji = shijianduan, tianqi, wendu, fengji
  end
  # def <=>(person) # Comparison operator for sorting
  #   @age <=> person.age
  # end
  def to_s
    "#@shijianduan (#@tianqi #@wendu #@fengji)"
  end
end


ws = []

#中央气象台天气
doc2.search("//div[@id ='weather6h']//table").each_with_index do |td,index|
  # puts tr.children
  puts index;
  i =0;
  w = Weather.new
 td.children.map do |c|
   
   if c.text.lstrip.length==0
     next
   end
   puts '*'*40
   if i==0
     w.shijianduan = c.text.encode('utf-8').chomp.strip.split("\r\n").join('').split("\s").join('')
   end
   if i==1
     w.tianqi = c.text.encode('utf-8').chomp.strip.split("\r\n").join('').split("\s").join('')
 
   end
   if i==2
     w.wendu = c.text.encode('utf-8').chomp.strip.split("\r\n").join('').split("\s").join('')
   end
   if i==3
     w.fengji = c.text.encode('utf-8').chomp.strip.split("\r\n").join('').split("\s").join('')
   end
   puts c.text.encode('utf-8')
   i+=1
  end
  ws<<w
end




body ="" 

doc2.search("//div[@class ='ybnews']").each_with_index do |td,index|
  # puts tr.children
  puts index;
 td.children.map do |c|
 
   if c.text.lstrip.length==0
     next
   end
     puts '*'*40
     puts c.text.encode('utf-8')
     
      body =body+c.text.encode('utf-8')+ "\r\n"
   end
end


# puts ws



ws.each{|v|
  # puts sprintf('%s',v)
  body =body+v.to_s+ "\r\n"
} 

mymail = MyMail.new
mymail.send('/Users/wwb/Desktop/tmpruby/Icon.gif','北京天气',body)
puts body
# puts '#'*40
# doc2.search("//div[@id ='index']//dl").each_with_index do |td,index|
#   # puts tr.children
#   puts index;
#  td.children.map do |c|
#  
#    if c.text.lstrip.length==0
#      next
#    end
#      puts '*'*40
#      puts c.text.encode('utf-8')
#    end
# end