 # Dir.mkdir("./testdir")
 # f=File.new(File.join("./testdir/","Test.xml"), "w+")   # 文件名和格式任意
 # NAME = "wwb"
 # f.puts("<?xml version='1.0' encoding='utf-8'?>")
 #  f.puts('<Person>') 
 #  f.puts("<Name>#{NAME}</Name>")
 #  f.puts("<Age>55</Age>")
 #  f.puts("<Weight>120KG</Weight>") 
 #  f.puts('</Person>')    # 因为在捣鼓xml配置文件，就临时复制过来了，内容随意
 #  
  
  #require 'FileUtils'
  # list=Dir.entries('.')
  # list.each_index do |x|
  #   puts "x is #{x}  #{list[x]}"
  # end
   
  require 'pathname'  
  def change_name  
    puts "------------"  
    current_path = Pathname.new(File.dirname('.')).realpath  
    current_file_name = __FILE__  
    begin  
      Dir::foreach(current_path) do |file|  
        if file!="." and file!=".." and file!=".#{ current_file_name }.swp" and file!="#{ current_file_name }"  
          #puts "File:"+file    
          1.upto(9) do |i|  
            # File.rename("#{ i.to_s }#{ i.to_s }.rb", "#{ i.to_s }.rb")  
            puts "执行第#{ i }个文件  #{ i.to_s }#{ i.to_s }.rb"
          end  
          break  
        end  
      end  
      rescue => e  
        puts "错误："+e  
      #ensure   
      #  puts "请确保文件名是否匹配！"   
    end  
    puts "------------"  
  end  
   
   