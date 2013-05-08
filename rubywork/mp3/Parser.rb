class Parser  
public  
  def initialize()  
    @fetcher = Fetcher.new  
  end  
  
  def parse_mp3(html)  
    urls = html.scan(/<a href="(.*?)"/m)
    download_hosts_urls = {}  
    parse_threads = []  
    for url in urls do  
        if url[0] =~ /.*?\.mp3,,.*?/  
           parse_threads << Thread.new(url) do |url|  
              song_url = url[0].gsub(" ","%20")  
              download_url = parse_download_url(song_url)  
              if download_url  
                host =  download_url.scan(/\/\/(.*?)\//m)[0][0]   
                #We only want to find the best download url,so we needn't care duplicate key  
                download_hosts_urls[host] = download_url  
              end   
           end  
        end  
    end  
    parse_threads.each{|t| t.join}  
    puts "已经搜索到#{download_hosts_urls.size}个链接可以下载..."  
    exit(1) if download_hosts_urls.size == 0  
    puts "正在选择速度最快的链接..."  
    host = select_best_host(download_hosts_urls.keys)  
    download_hosts_urls[host]  
  end  
  
private  
  def select_best_host(hosts)  
    times_hosts = {}  
    threads = []  
    hosts.each do |host|  
      threads << Thread.new(host) do |host|  
           response = `ping -c 1 -W 30 #{host}` #use`ping -n 1 -w 30 #{host}` in windows  
           r_t = response.scan(/time=(\d+)/m) #only get integer part  
           times_hosts[r_t[0][0]] = host unless r_t.empty? #duplicate key no problem   
      end  
    end  
     
    threads.each{|t| t.join}  
     
    times = times_hosts.keys  
    min = times.min  
    times_hosts[min]  
  end  
  
  def parse_download_url(song_url)  
     html = @fetcher.fetch(song_url)  
     urls = html.scan(/<a href="(.*?)"/m)  
     return nil if urls.empty? || urls[0][0] =~ /.*?\.html/  
     return urls[0][0]        
  end  
end  