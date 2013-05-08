require "open-uri"  
load "parser.rb"  
load "fetcher.rb"  
  
class Download  
public  
  def initialize(song_name)  
    @song_name = song_name  
    @search_url = "http://mp3.baidu.com/m?f=ms&tn=baidump3&ct=134217728&lf=&rn=&word=12&lm=0"  
    @parser = Parser.new  
    @fetcher = Fetcher.new  
  end  
   
  def download  
    puts "正在建立连接..."  
    html = @fetcher.fetch(@search_url)  
    puts "正在获取搜索结果..."  
    url = "http://zhangmenshiting.baidu.com/data2/music/8012211/8011624144000128.mp3?xcode=c51fb655aab5bf5e70744b3b9b76a221"#@parser.parse_mp3(html)  
    puts "已经获得最快的下载连接:#{url}.\n开始下载..."  
    doDownload(url)      
    puts "下载完毕..."  
  end  
private  
  def doDownload(url)  
    open(url) do |fin|  
    size = fin.size  
    download_size = 0  
    puts "大小: #{size / 1024}KB"  
    filename = url[url.rindex('/')+1, url.length-1]  
    puts "歌曲名: #{filename}"  
    open(File.basename("./#{filename}"),"wb") do |fout|  
            while buf = fin.read(1024) do  
            fout.write buf  
            download_size += buf.size  
                print "已经下载： #{download_size * 100 / size}%\r"  
                STDOUT.flush   
           end  
       end  
    end   
    puts  
  end  
end  
  
download = Download.new("1")  
download.download  