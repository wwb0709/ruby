require "net/http"   
  
class Fetcher  
   
 def fetch(url)  
   # host = url.scan(/\/\/(.*?)\//m)[0][0]  
  #  path = url.split(/#{host}\//)[1]  
  # print "host: ",host,"\n"  
  # print "path: ",path,"\n"  
  #  h = Net::HTTP.new(host,80)  
  #  resp = h.get("/#{path}",nil)  
  uri = URI('http://music.baidu.com/search?from=new_mp3&key=12')
  resp = Net::HTTP.get(uri)
   puts resp.to_s
   return resp    
  
   if resp.message == "OK"  
    # puts "建立连接成功..."   
     return resp.body       
   end   
   return ""  
 end  
  
end  