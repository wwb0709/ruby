# words = ['foobar','hello','world']
# secret = words[rand(3)]
# print "guess?"
# while guess = STDIN.gets
#   guess.chop!
#   if guess = secret
#     puts "You win!"
#     break
#   else
#     puts "Sorry,you lose."
#   end
#   print "Guess？"
# end
# puts "The Word was ",secret,"."

def fact(n)
  if n ==0
    1
  else
    n* fact(n-1)
  end
end
puts fact(122)

grades = [88,99,73,56,87,64]   
sum = 0   
0.upto(grades.length - 1) do |loop_index|   
   sum += grades[loop_index]   
end  
average = sum / grades.length   
puts average