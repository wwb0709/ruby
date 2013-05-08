require 'find'
	  
	 def fileWalk(path)
        filename = "#{path}/log.txt"
        # unless File.exist?(filename)
        #     puts "${filename}exist" 
        #  else 
           myFile = File.new(filename,"w"); 
         # end
	       Find.find(path) do |f| 
	      type = "File" if File.file?(f)
	      type  = "Dir " if File.directory?(f)
	        if type != "File" && type != "Dir "
	          type = "   ?"
	        end
      # puts "#{type}: #{f}" 
      
      if type == "File"
        myFile.puts "#{type}: #{f}" 
      end
  
	  end 
    myFile.close #只有close掉了内容才被写入文件里面。  
	end
	 
	fileWalk('/Users/wwb/desktop/rubywork') #put whatever folder here
  
  
  #读文件
  print "Please input a file name:"  
    filename = "/Users/wwb/desktop/rubywork/log.txt"
    # if filename &&!filename.empty?#文件存在  
    #     filename = filename[0,filename.length-1]  
    #     #去掉文件名后面的"\n"  
    # else  
    #     print "the file name can't be null!"  
    #     exit(1)  
    # end  
      
    if File.exist?(filename)  
        puts "=========#{filename}========="  
        File.open(filename,"r") do |file|  
             while line = file.gets  
                puts line  
             end  
        end  
        puts "=================="  
    else  
        puts "the program can't find the file #{filename}"  
    end  
  
  # require 'Find'
# 
#   dirSize = 0
#   Find.find("/Users/wwb/desktop/rubywork") do |f| 
#     dirSize += File.size(f)
#   end
# 
#   puts dirSize