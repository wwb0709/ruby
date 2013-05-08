require 'rubygems'  
require 'hpricot'  
require 'open-uri'  
require 'iconv'  
  
def _mktab(x)  
  t0 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"  
  p = t0.partition(x)  
  p[1] + p[2] + p[0]  
end  
  
def decode(s)  
  s.tr(_mktab(s[0].chr), s=~ /....:\// ? _mktab('h') : _mktab('f')) #http|ftp  
end  
  
def tiny_url(url, encode = false)  
  result = open(encode ? URI.encode("http://tinyurl.com/api-create.php?url=#{url}") : "http://tinyurl.com/api-create.php?url=#{url}").read  
  result =~ /^Error/ ? url : result  
end  
  
def actual_download_url(search_url, limit = 2)  
  doc = Hpricot(open(search_url))  
  doc.search("table#Tbs td.d a").map{|a| a.attributes["href"]}[0..limit].map {|url|  
    decode(open(URI.encode(url)).read[/var I="([^"]*)"/, 1])  
  }  
end  
  
def get_maidu_mp3_top100  
  url = "http://list.mp3.baidu.com/list/newhits.html"  
  doc = Hpricot(Iconv.conv("UTF8", "GBK", open(url).read))  
  result = {}  
  doc.search("table.list td:not(.th)").each{|t|  
    name = t.inner_text.gsub(/\s+/, " ")  
    search_url = t.search("a")[0].attributes["href"]  
    result[name] = search_url  
  }  
  return result  
end  
  
def get_new_data  
  local_data = File.open('data.yaml') { |file| YAML::load(file) } rescue {}  
  remote_data = get_maidu_mp3_top100  
  new_data = {}  
  remote_data.each_pair { |key, value|  
    unless local_data.has_key?(key)  
      local_data[key] = value  
      new_data[key] = value  
    end  
  }  
  File.open('data.yaml', 'w') { |file| YAML.dump(local_data, file) }  
  return new_data  
end  
  
def update_javaeye_chat(username, password)  
  get_new_data.each_pair { |key, value|  
    message = "#{key} 搜索 #{tiny_url value}"  
    actual_download_url(value).each_with_index{|url, index|  
      message << " 下载#{index+1} #{tiny_url(url, true)}"  
    }  
    open(URI.encode("http://www.iteye.com/api/twitters/create?body=#{message}"), :http_basic_authentication=>[username, password]).read  
  }  
end  
  
update_javaeye_chat("wwb1111", "wwb0916")  