#E8.3-3.rb

# strdoc=<<DOC_EOF
# This is windows2000 or windows98 system.
# Windows system is BEST?
# Windows2000 running in 12-31-2006,°≠°≠
# DOC_EOF
# 
# re = /[w|W]indows(?:98|2000) /
# strdoc.gsub!(re, "Windows XP ") 
# re = /[1-9][0-9]\-[1-9][0-9]\-\d\d\d\d/
# time = Time.now.strftime("%m-%d-%Y")
# strdoc.gsub!(re, time) 
# puts strdoc
# 3.times {print strdoc}
# 
# 
# (1..9).each {|i| print i if i<5}
# 
# puts pro{|i| n+=i}


#=======================================

puts "Today's date is: 5/6/2013".scan(/(?<month>\d{1,2})\/(?<day>\d{1,2})\/(?<year>\d{4})/)








