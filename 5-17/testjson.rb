# require 'net/http'  
# require 'uri'  
# require 'json'  
# 
# customers = [{  
#     "id" => 1123,  
#     "name" => "B-abc",  
#     "citys" => "",   
#     "company" => "",  
#     "siteUrl" => "www.abc.com",  
#     "domain" => "www.abc.com",  
#     "contact" => "张三",  
#     "phone" => "12222222",   
#  
#     "testarr" =>
#     
#     {  
#         "ssid" => 1123,  
#         "ssname" => "B-abc",  
# 
#     },   
#     "status" => 1  
# }]
# p customers.to_json
# 
# puts JSON.parse customers.to_json





require "rubygems"
require "json"

string = '{"desc":{"someKey":"someValue","anotherKey":"value"},"main_item":{"stats":{"a":8,"b":12,"c":10}}}'
parsed = JSON.parse(string) # returns a hash

# p parsed["desc"]["someKey"]
# p parsed["main_item"]["stats"]["a"]
# 
# # Read JSON from a file, iterate over objects
# file = open("shops.json")
# json = file.read
# 
# parsed = JSON.parse(string)
# 
p parsed
parsed["main_item"].each do |shop|
  k = shop
   p k
  
  # k.each{|key1, hash1|
  #        # hash1.each {|key2,v2|
  #            #print "hash #{key1} has keys:", hash1.keys.join(','), "\n"
  #            puts key1,hash1
  #            p key1
  #             hash1.each {|key2,v2|
  #                #print "hash #{key1} has keys:", hash1.keys.join(','), "\n"
  #                puts key2
  #              }
  #        # }
  #    }
  # p k[1]["a"]
  # p k[1]["b"]
end





# require "rubygems"
# require "json"
# 
# string = '{"userid":"8888","pm":"i386","ar":"10","p":"51","c":"0","os":"IOS","list":"4000050217,4000070217,4000670128,4000677128,12306,95105105","ver":"V2.8.0","pb":"IOS","m":"","pcode":"10008","imsi":"f55ef75c80a853c0892dab1aa1d3fc2200000000","channel":"z00003"}'
# parsed = JSON.parse(string) # returns a hash
# 
# # p parsed
# p parsed["pm"]




# module SafeJSON
#   require 'monitor'
#   def SafeJSON.build_safe_json
#     ret = nil
#     waiter = ''
#     waiter.extend(MonitorMixin)
#     wait_cond = waiter.new_cond
#     
#     Thread.start do
#       $SAFE = 4
#       ret = Proc.new {|json|
#         eval(json.gsub(/(["'])\s*:\s*(['"0-9tfn\[{])/){"#{$1}=>#{$2}"})
#       }
#       waiter.synchronize do
#         wait_cond.signal
#       end
#     end
#     waiter.synchronize do
#       wait_cond.wait_while { ret.nil? }
#     end
#     return ret
#   end
#   @@parser = SafeJSON.build_safe_json
#   
#   # Safely parse the JSON input
#   def SafeJSON.parse(input)
#     @@parser.call(input)
#   rescue SecurityError
#     return nil
#   end
# end


# peoples=SafeJSON.parse('{"peoples":[{"name":"site120","email":"site120@163.com","sex":"男"},{"name":"site120_2","email":"site120@163.com_2","sex":"男_2"}]}')
# puts peoples["peoples"][1]["name"]  #输出site120_2