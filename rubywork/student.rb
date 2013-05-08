load "person.rb"
module Me
  def sqrt(num, rx=1, e=1e-10)
    num*=1.0
    (num - rx*rx).abs <e ? rx : sqrt(num, (num/rx + rx)/2, e)
   end
end
class Student < Person 
  @@count=0
  # def initialize 
  #   @@count+=1
  # end
  def talk
    super
    puts "I am a student. my name is "+@name+", age is "+@age.to_s 
    puts "I am #@name, This class have #@@count students."
  end # talk 方法结束
end # Student 类结束 
p3=Student.new("kaichuan",25); 
p3.talk 
p4=Student.new("Ben"); 
p4.talk

p4.extend(Me)
puts p4.sqrt(93.1, 25)
# 9.64883412646315


def one_block
  for num in 1..3
    yield(num)
  end
end


one_block do|i|
  puts "This is block #{i}."
end


class Array
def one_by_one
for i in 0..size
   yield(self[i] )
end
puts end
end
arr = [1,3,5,7,9] 
arr.one_by_one {|k| print k,","}