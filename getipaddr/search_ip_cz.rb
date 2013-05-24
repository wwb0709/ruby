require 'iconv'

class IpLocationSeeker
  def initialize()
    fQQwry='QQWry.Dat'
    #@datafile = File.open(fQQwry,"r:utf-8")
    @datafile = File.open(fQQwry,"rb")
    @first_index_pos,@last_index_pos  = @datafile.read(8).unpack('L2')
    @index_num = (@last_index_pos - @first_index_pos)/7 + 1
  end

  def renamed_eump(number=100)
    p 'renamed eump' if $DEBUG
    last_index_pos = number * 7
    last_index_pos = @last_index_pos if last_index_pos > @last_index_pos
    current_num = 0
    error_num = 0
    @first_index_pos.step(last_index_pos,7) do |a_pos|
        begin
          current_num +=1
          @datafile.seek(a_pos)
          ip_int = @datafile.read(4).unpack('L1')
          @ip_record_pos = three_bytes_long_int(@datafile.read(3).unpack('C3'))
          puts ip_int.to_s + "***"+get_country_string + '***' + get_area_string
        rescue
          err
          puts "error at " + current_num.to_s
          error_num += 1
        end
      end
    return "total num:%s,error_num:%s  " %[current_num,error_num]
  end

  def seek(ip_str) #查询IP
    p ' seek' if $DEBUG
    @ip_str = ip_str
    @ip_record_pos = get_ip_record_pos
    begin #错误处理
      return get_country_string + get_area_string
    rescue Interrupt
      return ip_str
    rescue Exception => detail
      err
      return ip_str
    #~ retry
    end
  end

  def half_find(ip_want_int,index_lowest,index_highest) #二分
     if index_highest - index_lowest == 1
          index_lowest
     else
        index_middle = (index_lowest + index_highest)/2
        file_offset = @first_index_pos + index_middle * 7
        @datafile.seek(file_offset)
        ip_middle_int = @datafile.read(4).unpack("L")[0]
        if ip_want_int == ip_middle_int
           index_lowest
        elsif ip_want_int > ip_middle_int
           index_lowest = index_middle
           half_find(ip_want_int,index_lowest,index_highest)
        else
           index_highest = index_middle
           half_find(ip_want_int,index_lowest,index_highest)
        end
     end
  end

  def three_bytes_long_int(three_byte)
    (three_byte[2] << 16) + (three_byte[1]<<8) + three_byte[0]
  end

  def get_ip_record_pos()
    p 'get ip record pos' if $DEBUG
    ip_record_pos_pos = @first_index_pos + half_find(my_inet_aton(@ip_str),0,@index_num-1)*7 + 4
    @datafile.seek(ip_record_pos_pos)
    three_byte = @datafile.read(3).unpack('C3')
    three_bytes_long_int(three_byte)
  end

  #读取直到字符串结尾
  def read_zero_end_string(file_pos)
    p 'read 0 str' if $DEBUG
    @datafile.seek(file_pos)
    str = ""
    count = 0
    while c = @datafile.getc
      break if count>100
      break if c.ord < 0x32
      str << c
      count += 1
    end
    if count > 70
      puts 'ipwry count:' + count.to_s
      str = "2 unknown string."
      @get_country_string_error = true
    end
    @after_read_country_pos = @datafile.pos
    return Iconv.conv("UTF-8//IGNORE","GB18030//IGNORE",str) rescue ''
  end

  #private

  def get_country_string()
    p 'get country str' if $DEBUG
    @get_country_string_error = false
    begin
      @datafile.seek(@ip_record_pos + 4)
      @mode_flag,  = @datafile.read(1).unpack("C1")
      if @mode_flag == 1 #the next three bytes are another pointer
        @ip_record_level_two_pos = three_bytes_long_int(@datafile.read(3).unpack('C3'))
        @datafile.seek(@ip_record_level_two_pos)
        @level_two_mode_flag, = @datafile.read(1).unpack("C1")
        if @level_two_mode_flag == 2
          @ip_record_level_three_pos = three_bytes_long_int(@datafile.read(3).unpack('C3'))
          @level_three_mode_flag, = @datafile.read(1).unpack("C1")
          read_zero_end_string(@ip_record_level_three_pos)
        else
          @level_two_mode_flag = 0
          read_zero_end_string(@ip_record_level_two_pos)
        end
      elsif @mode_flag == 2
        @ip_record_level_two_pos = three_bytes_long_int(@datafile.read(3).unpack('C3'))
        read_zero_end_string(@ip_record_level_two_pos)
      else
        @mode_flag = 0
        read_zero_end_string(@ip_record_pos + 4)
      end
    rescue
      err
      @get_country_string_error = true
      return "unknown country!"
    end
  end

  def get_area_string()
    p 'get area string' if $DEBUG
    @get_area_string_error = false
    if @get_country_string_error
      @get_area_string_error = true
      return "4 unknown area!"
    end
    begin
      if @mode_flag == 0
        read_zero_end_string(@after_read_country_pos)
      elsif @mode_flag == 1
        if @level_two_mode_flag == 2
          #p @level_three_mode_flag
          if @level_three_mode_flag == 1 || @level_three_mode_flag == 2
            @datafile.seek(@ip_record_level_two_pos + 5)
            @ip_record_area_string_pos = three_bytes_long_int(@datafile.read(3).unpack('C3'))
            read_zero_end_string @ip_record_area_string_pos
          else
            read_zero_end_string(@ip_record_level_two_pos + 4)
          end
        else
          read_zero_end_string(@after_read_country_pos)
        end
      else
        read_zero_end_string(@ip_record_pos+8)
      end
    rescue
      err
      @get_area_string_error = true
      return "unknown area!"
    end
  end
  def err
    p $!.message + $@[0]
  end

  def my_inet_aton(ip_str)
    ip_str.split(".").collect{|x|x.to_i}.inject(0){|ip_int,ip_field|
      ip_int = (ip_int << 8) + ip_field
    }
  end
end

before= Time.now

#IP数据文件路径
ip='124.207.84.210'
p IpLocationSeeker.new.seek(ip)



interval=(Time.now-before)

p 'usetime:'+interval.to_s+'s'#耗时

# a = "B0B2BBD5CAA1BACFB7CACAD0D6D0B9FABFC6D1A7BCBCCAF5B4F3D1A7"
# p a.encode('UTF-8', 'UTF-16')


