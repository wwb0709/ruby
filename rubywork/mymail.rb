#configure


$from_who="wwb1111@163.com"
$pass="wwb0916"
$to_who_arr = ['249907555@qq.com','xuesong19870605@vip.qq.com']#
$to_who=$to_who_arr.join(',')
$smtp_server="smtp.163.com"
$smtp_port=25


#mail body
# $subject="This is the body subject"
# $mail_body= "This is what people with plain text mail readers will see"

#require
require 'net/http'
require 'net/smtp'
require 'rubygems'
require 'mailfactory'
# load 'mailfactory_enhence.rb'

# puts "sendmail to #{ARGV[0]}, #{ARGV[1]}, #{ARGV[2]}, #{ARGV[3]}";

class MyMail
  def send(file,subject,body)
    puts "#{file} #{subject} #{body}"
    mail=MailFactory.new 
     mail.encoding="GBK" #设置encoding
     mail.to=  $to_who #多个收件人
     mail.from=$from_who 
     
     mail.subject="#{subject}"
     # mail.html=
#      "<html>
# 
# <head>
# 
# <title>Title of page</title>
# 
# </head>
# 
# <body>
# <p><font color=\"#FF0000\">测试</font></p>
# 
# This is my first homepage. <b>This text is bold</b>
# 
# </body>
# 
# </html>"
     # Net::HTTP.get(URI.parse('http://www.baidu.com'))

      mail.text="#{body}"#Net::HTTP.get(URI.parse('http://www.google.cn'))
   
      mail.attach("#{file}")
  
     Net::SMTP.start('smtp.163.com',25,'163.com','wwb1111@163.com','wwb0916',:login) do |smtp|
       smtp.send_message(mail.to_s(),$from_who, $to_who_arr)
     end
  end
 end
# mymail = MyMail.new
# mymail.send('/Users/wwb/Desktop/tmpruby/Icon.png','hello','hello')
