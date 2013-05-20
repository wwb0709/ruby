#=begin
# Hard
sudoku = [
 # 0  1   2   3   4   5   6  7   8
  [0, 0, 0, 0, 0, 3, 0, 8, 1],  # 0
  [2, 0, 0, 4, 0, 0, 0, 0, 0],  # 1
  [0, 5, 0, 0, 0, 0, 0, 0, 0],  # 2
  [0, 0, 0, 2, 3, 0, 7, 0, 0],  # 3
  [0, 1, 0, 0, 0, 0, 0, 5, 0],  # 4
  [0, 0, 8, 6, 0, 0, 0, 0, 0],  # 5
  [7, 0, 0, 0, 0, 0, 4, 0, 0],  # 6
  [0, 9, 0, 0, 8, 0, 0, 0, 0],  # 7
  [0, 0, 0, 0, 5, 0, 2, 0, 0]   # 8
]
#=end
=begin
# Normal
sudoku = [
 # 0  1   2   3   4   5   6  7   8
  [0, 5, 1, 6, 0, 0, 0, 0, 0],  # 0
  [0, 0, 9, 0, 0, 0, 0, 8, 2],  # 1
  [0, 0, 8, 0, 0, 0, 0, 0, 0],  # 2
  [2, 0, 0, 0, 8, 0, 0, 4, 3],  # 3
  [3, 0, 0, 7, 0, 0, 0, 2, 0],  # 4
  [0, 0, 0, 0, 0, 0, 5, 0, 0],  # 5
  [0, 0, 2, 1, 0, 5, 6, 0, 0],  # 6
  [8, 4, 0, 0, 0, 0, 2, 0, 5],  # 7
  [0, 0, 0, 0, 0, 0, 0, 0, 9]   # 8
]
=end
=begin
# Easy
sudoku = [
 # 0  1   2   3   4   5   6  7   8
  [0, 6, 8, 7, 0, 0, 3, 0, 0],  # 0
  [0, 1, 4, 9, 0, 0, 0, 2, 8],  # 1
  [0, 0, 0, 0, 0, 8, 0, 0, 0],  # 2
  [8, 0, 7, 2, 0, 0, 0, 0, 0],  # 3
  [0, 2, 0, 0, 0, 0, 0, 6, 1],  # 4
  [1, 0, 0, 0, 0, 0, 0, 5, 0],  # 5
  [9, 0, 0, 0, 0, 2, 7, 4, 5],  # 6
  [4, 0, 0, 0, 5, 0, 0, 0, 0],  # 7
  [0, 0, 0, 4, 1, 0, 0, 0, 0]   # 8
]
=end
=begin
# Test
sudoku = [
 # 0  1  2  3  4  5  6  7  8
  [3, 2, 7, 5, 4, 6, 9, 8, 1],  # 0
  [1, 8, 5, 3, 9, 7, 2, 6, 4],  # 1
  [4, 6, 9, 2, 8, 1, 3, 7, 5],  # 2
  [9, 3, 1, 4, 6, 8, 5, 2, 7],  # 3
  [8, 5, 4, 9, 7, 2, 6, 1, 3],  # 4
  [2, 7, 6, 1, 3, 5, 8, 4, 9],  # 5
  [6, 1, 3, 7, 2, 9, 4, 5, 8],  # 6
  [5, 9, 8, 6, 1, 4, 7, 3, 2],  # 7
  [7, 4, 2, 8, 5, 3, 1, 9, 6]   # 8
]
=end
=begin
# Test
sudoku = [
 # 0  1   2   3   4   5   6  7   8
  [3, 2, 7, 5, 4, 6, 9, 8, 1],  # 0
  [1, 8, 5, 3, 9, 7, 2, 6, 4],  # 1
  [4, 6, 9, 2, 8, 1, 3, 7, 5],  # 2
  [9, 3, 1, 4, 6, 8, 5, 2, 7],  # 3
  [8, 5, 4, 9, 7, 2, 6, 1, 3],  # 4
  [2, 7, 6, 1, 3, 5, 8, 4, 9],  # 5
  [6, 1, 3, 7, 0, 0, 0, 0, 0],  # 6
  [5, 9, 8, 6, 0, 0, 0, 0, 0],  # 7
  [7, 4, 2, 8, 0, 0, 0, 0, 0]   # 8
]
=end

class SudokuResolver
  
  attr_reader :sudoku
  
  def initialize sudoku
    @sudoku = sudoku.copy
    update_sudoku
  end

  # put sudoku into @units
  def update_sudoku
    @units = []
    # row 0 - 8
    0.upto(8) {|i| @units << @sudoku[i]}
    
    # column 9 - 17
    0.upto(8) do |i|
      column = []
      0.upto(8) {|j| column << @sudoku[j][i]}
      @units << column
    end
    
    # block 18 - 26
    0.upto(2) do |i|
      0.upto(2) do |j|
          block = []
          block << @sudoku[i * 3][j * 3]
          block << @sudoku[i * 3][j * 3 + 1]
          block << @sudoku[i * 3][j * 3 + 2]
          block << @sudoku[i * 3 + 1][j * 3]
          block << @sudoku[i * 3 + 1][j * 3 + 1]
          block << @sudoku[i * 3 + 1][j * 3 + 2]
          block << @sudoku[i * 3 + 2][j * 3]
          block << @sudoku[i * 3 + 2][j * 3 + 1]
          block << @sudoku[i * 3 + 2][j * 3 + 2]
          @units << block
      end
    end
    
  end
  
  # resolve sudoku
  def resolve_sudoku
    # step 1: Check
    return false unless is_vaild?
    return true if is_resolved?
    
    # step 2: fill definite value
    flag = true
    while flag
      flag = false
      @units.each_with_index do |unit, index|
        if unit.count(0) == 1
          flag = true
          value = ([1,2,3,4,5,6,7,8,9] - unit)[0]
          if index >= 0 && index <= 8
            @sudoku[index][unit.index(0)] = value
          end
          if index >= 9 && index <= 17
            @sudoku[unit.index(0)][index - 9] = value
          end
          if index >= 18 && index <= 26
            i = index - 18
            #puts "value: #{value}, index: #{unit.index(0)}, i: #{(i / 3) * 3 + unit.index(0) / 3}, j: #{i % 3 * 3 + unit.index(0) % 3}"
            @sudoku[(i / 3) * 3 + unit.index(0) / 3][i % 3 * 3 + unit.index(0) % 3] = value
          end
        end
      end
      update_sudoku
    end
    
    
    return false unless is_vaild?
    return true if is_resolved?
    
    # step 3: generate marked sudoku
    generate_mark_sudoku
    
    # step 4: get the cell with least probable value
    ij_hash = {}
    min = 9
    @mark_sudoku.each_with_index do |unit, i|
      unit.each_with_index do |arr, j|
        if arr.respond_to?("each")
          #puts "#{i}, #{j}"
          if(arr.size == 1)
            @sudoku[i][j] = @mark_sudoku[i][j][0]
            next
          end
          ij_hash[arr.size.to_s.to_sym] ||= []
          ij_hash[arr.size.to_s.to_sym] << [i, j]
          min = arr.size if min >= arr.size
        end
      end
    end
    
    update_sudoku
    return false unless is_vaild?
    return true if is_resolved?
    return false if min == 0
    
    # step 5: try to fill the cell getted from step 4.
    
    ij_hash[min.to_s.to_sym].each do |ij|
      
      @mark_sudoku[ij[0]][ij[1]].each do |value|
        temp_sudoku = @sudoku.copy
        temp_sudoku[ij[0]][ij[1]] = value
        
        #推导过程
        #puts "sudoku, i: #{ij[0]}, j: #{ij[1]}, value: #{value}"
        #temp_sudoku.each {|line| line.each {|i| print "\t#{i}"};print "\r"}
        #puts "-----------------------------------------"
        #@mark_sudoku.each {|line| line.each {|i| print "\t#{i}"};print "\r"}
        #puts "-----------------------------------------"
        sub_resolver = SudokuResolver.new(temp_sudoku)
        if sub_resolver.resolve_sudoku
          @sudoku = sub_resolver.sudoku.copy
          return true
        end
      end
      return false
    end
    
    return false
    
  end

  
  
  
  # 如果数独被解出，则返回true。
  def is_resolved?
    @units.each {|unit| return false if unit.include? 0}
    true
  end
  
  # 检验数独是否正确
  def is_vaild?
    @units.each do |unit|
      return false unless unit.with_unique [1,2,3,4,5,6,7,8,9]
    end
    true
  end
  
  def generate_mark_sudoku
    @mark_sudoku = []
    @sudoku.each_with_index do |unit, i|
      @mark_sudoku[i] = []
      unit.each_with_index do |n, j|
        unless n == 0
          @mark_sudoku[i][j] = -1  # -1 stands for value existing.
        else
          unit1 = @units[i]
          unit2 = @units[9 + j]
          unit3 = @units[18 + i / 3 * 3 + j / 3]
          @mark_sudoku[i][j] = [0,1,2,3,4,5,6,7,8,9] - unit1 - unit2 - unit3
        end
      end
    end
  end

end

# add methods in class Array.
class Array
  
  def count ele
    counter = 0
    self.each {|i| counter = counter + 1 if i == ele}
    counter
  end

  def with_unique array
    self.each {|i| array.each {|j| return false if self.count(j) > 1}}
    true
  end

  def copy
    arr = []
    self.each {|i| arr << i.clone}
    arr
  end

end



resolver = SudokuResolver.new sudoku
t1 = Time.now
if resolver.resolve_sudoku
  resolver.sudoku.each {|line| line.each {|i| print "\t#{i}"};print "\r"}
else
  puts "No Solution"
end
t2 = Time.now
puts t2 - t1



# 把数独放进二维数组传入SudokuResolver类。
# 第一步：使用方法update_sudoku初始化数独，把数独解析到27个数组中(@units)，既9行，9列，9个方块。如果9个数组都没有0（0代表没填值）且每个数组都没有重复值的话那么数独就算解出来了。
# 第二步：使用方法resolve_sudoku解数独……
# 再解释一下resolve_sudoku方法。
# 第一步，如果不合法直接return false，如果被解出来return true，跳出递归。
# 第二步，填上确定值，即如果一个数组已经有8个值了，那么显然另外一个值能轻易计算出来。填完之后再重复一下第一步（其实第一步可以省略）。
# 第三步，生成一个新二维数组@mark_sudoku跟存放数独的数组对应，不同的是新数组每个格子存放的是这个格子可能出现的值，如果已经填好值得存-1用来区别。
# 第四部，查找@mark_sudoku中可能出现值最少的格子，然后再原数独里填上可能出现的值，进行下一轮递归。
# 
# 效率方面，我测试用的3个数独，简单，中等的要计算1秒左右，复杂那个算了2分钟多（这要人做估计能做一天了）。
# 我另一个同事用php做的效率比我高很多，没有写类，就一个方法做递归，少了好多初始化过程，他就用一个方法，参数是数独数组（一维），然后每次填一个值，如果填不了值就跳出（说明数独无解），填值后再递归……谁有空翻译成ruby的看看是不是效率确实快很多……
# 最后感谢我那位同事帮我调试脚本……ruby写起来舒服调试起来想死，求推荐好的IDE……