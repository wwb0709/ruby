math_score={
 "王红"=>100,
 "岳峰"=>99,
 "李佳路"=>98,
 "张小春"=>97,
 "关世晓"=>94
}
puts "This record "+math_score.size.to_s+" students' math score."
puts "With each method to output every student's math score: "
math_score.each do |key, value|
 puts key.to_s + ": " +value.to_s
end

puts "========================="
brand = "Nokia"
model = "5000"
color = "Purple"
listing_date = "May 2008"
price = "410"
sale = 0.8
puts "Brand: " + brand
puts "Model: " + model
puts "Color: " + color
puts "Lifting date: " + listing_date
puts "Marketing Price: " + price
puts "Sale: " + (price.to_i*sale).to_s


 #14. Ruby求素数的算法
puts "========================="
$arr = []
$arr[0] = 2
def add_prime(n)
 3.step(n,2) {|num| $arr << num if is_prime? num }
end
def is_prime?(number)
 j = 0
 while $arr[j] * $arr[j] <= number
  return false if number % $arr[j] == 0
  j += 1
 end
 return true
end
add_prime(50)
print $arr.join(", "), "\n"

puts "========================="
class Student
 def initialize(number, name)
  @number=number
  @name=name
 end
 
 attr_accessor :number, :name
end

def each(stus)
 for stu in stus
  yield(stu)
  puts stu.number + "\t" + stu.name
 end
end

students=Array.new
students[0]=Student.new("001", "Zhang Wen")
students[1]=Student.new("002", "Li Bei")
students[2]=Student.new("003", "Liu Jingsheng")

each(students) do
 |stu| stu.number= "stu" + stu.number
end
puts "========================="+"-----------"

def histogram(a)

       a.inject(Hash.new(0)) { |hash, x| hash[x] += 1; hash }

end

 

a=[1, 2, 3, 4, 5,1,2,3,7,3]

h=histogram(a)

h.each{|k,v| print k,"=>",v,"\n"}

puts "---------------------------"
for i in 1..10 do
puts i
end

Dir.foreach("/tmp") do |d| puts d end 

File.new("/Users/wwb/Desktop/test.rb").each_line do |s|

puts s

end 


 
lth=[]
$url="http://rdoc.info"
puts "get url #{$url}..."
doc = Nokogiri::HTML(open($url))
doc.css('ul.libraries')[1].css('li').each_with_index do |li,i|
 aname =li.css('a').first
  name=aname.content
  purl=$url+aname['href']
	  lth << Thread.new(i,name,purl) { |j,n,u| extract_readme_header(j,n,u)  }
	end
  