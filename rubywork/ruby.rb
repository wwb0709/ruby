$arr = []
$arr[0] =2
puts $arr

def add_prime(n)
  3.step(n,2){|num|$arr<<num if is_prime?num}
end

def is_prime?(n)
  j =0
  while $arr[j]*$arr[j]<n
    return false if n % $arr[j]==0
    j+=1
  end
  return true
end

add_prime(50)
puts $arr.join(","),"\n"