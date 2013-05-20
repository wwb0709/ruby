def traverse_dir(file_path)  
  if File.directory? file_path  
    Dir.foreach(file_path) do |file|  
      if file!="." and file!=".."  
        traverse_dir(file_path+"/"+file){|x| yield x}  
      end  
    end  
  else  
    yield  file_path  
  end  
end  
  
s  = '/Users/wwb/desktop/directory' 
traverse_dir(s){|f|  
  puts f
  IO.readlines(f).each_with_index{
    |line,index|
    puts "#{index} ----#{line}"
    
    # if line =~/\b\w\b/
   #    puts "hh#$1"
   #  
   #  end
    
  }
  # if f.to_s() =~ /\.jsp$/ || f.to_s() =~ /\.css$/  
  #   IO.readlines(f).each { |line|  
  #     if line =~ /([^""']*gif)/  
  #       puts " #$1"  
  #     end  
  #   }  
  #   #puts f  
  # end  
} 