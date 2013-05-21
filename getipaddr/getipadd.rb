require 'rubygems'
require 'ipparse'

fh = File.new("ip.csv", "w")  #创建一个可写文件流
                
              
File.open('iplist.csv') do |file|
    while line = file.gets
       mip = IPParse.parse(line) 
        fh.puts line +','+ mip
       puts line + mip
     end
end
  fh.close #关闭文件流