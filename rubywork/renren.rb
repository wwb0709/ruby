#encoding: utf-8

# require 'mechanize'
# require 'logger'
# 
# agent = Mechanize.new
# agent.log = Logger.new "mech.log"
# agent.user_agent_alias = 'Mac Safari'
# 
# page = agent.get "http://www.google.com/"
# search_form = page.form_with :name => "f"
# search_form.field_with(:name => "q").value = "Hello"
# 
# search_results = agent.submit search_form
# puts search_results.body
require 'rubygems'
require 'mechanize'
require 'logger'
class Renren

  def initialize(e,p)
    @agent = Mechanize.new
      @agent .log = Logger.new "mech.log"
    @page = @agent.get('http://3g.renren.com/')
    @page = @page.form_with(:method => 'POST') do |r|
      r.email = e
      r.password = p
    end.submit
  end

  def fetch_other_photo(album_link,foldername)
    photo_urls = []
    puts Iconv.conv("gb2312", "utf-8", "开始分析相册地址.....")
    begin
      user_id,album_id = parse_album_uri(album_link)
    rescue
      puts Iconv.conv("gb2312", "utf-8", "您的相册地址不正确，请重新输入！")
      return
    end
    page = @agent.get("http://3g.renren.com/album/wgetalbum.do?id=#{user_id}&owner=#{album_id}")
    puts Iconv.conv("gb2312", "utf-8", "正在获取所有照片地址.....")
    loop do
      page.links_with(:href => /http:\/\/3g\.renren\.com\/album\/wgetphoto\.do?/).each do |link|
        photo = link.click
        photo_urls << photo.link_with(:text => "下载该图").href
      end
      break if page.link_with(:text => "下一页").nil?
      page = page.link_with(:text => "下一页").click
    end
    if photo_urls.length > 0
      puts Iconv.conv("gb2312", "utf-8", "开始下载相册.....")
      unless File.directory?("#{foldername}")
        Dir.mkdir("#{foldername}")
      end
      Dir.chdir("#{foldername}") do |path|
          photo_urls.each do |photo_url|
            @agent.get(photo_url) do |photo|
              puts Iconv.conv("gb2312","utf-8","正在保存文件#{photo.filename}……已经下载#{((photo_urls.index(photo_url)+1).to_f/photo_urls.length*100).to_i}%")
              photo.save
            end
          end
      end
      puts Iconv.conv("gb2312","utf-8","相册下载完毕.....")
    else
      puts Iconv.conv("gb2312","utf-8","相册内没有照片哟~")
    end
  end

  private

  def parse_album_uri(uri)
    uri = uri.chomp("#thumb")
    uri = uri.split("?")
    if uri.length > 1 and uri[1].include?("owner")
      uri = uri[1].split("&")
      user_id = uri[0].split("=")[1]
      album_id = uri[1].split("=")[1]
    else
      uri = uri[0].split("/")
      album_id = uri[4]
      user_id = uri[5].split("-")[1]
    end
    return user_id,album_id
  end
end

print Iconv.conv("gb2312","utf-8","用户名：")
username = gets.chomp()
print Iconv.conv("gb2312","utf-8","密码：")
password = gets.chomp()
renren = Renren.new(username,password)
loop do
  print Iconv.conv("gb2312","utf-8","粘贴相册地址：")
  uri = gets.chomp()
  renren.fetch_other_photo(uri, username)
  print Iconv.conv("gb2312","utf-8","按0退出程序，按其它键继续下载其它相册：")
  break if gets.chomp() == "0"
end