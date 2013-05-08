class Person
  def initialize(name,age =18)
    @name = name
    @age = age
    @motherland = "China"
     puts "initialize my name is "+@name+", age is "+@age.to_s
  end
  def talk
    puts "my name is "+@name+", age is "+@age.to_s
    if @motherland == "China"
      puts "I am a Chinese."
    else
      puts "I am a foreigner." 
    end
  end
  
  
  # attr_writer :motherland
  attr_accessor :motherland
end


p1 = Person.new("hello",20)
# p1.motherland = "world"
p1.talk

p2=Person.new("Ben") 
p2.motherland="ABC"
p2.talk