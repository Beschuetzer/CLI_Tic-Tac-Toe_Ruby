class Board
  #0 = open, 1 = player 1, 2 = player 2
  @@positions_played = [1,2,0,1,2,2,1,1,0]    
  @@lines_before = 3
  @@chars_across = 17
  @@spaces = 3
  @@line = " " * (@@chars_across/3) + "|" + " " * (@@chars_across/3) + "|" + " " * (@@chars_across/3)
  @@positions_available = [1,2,3,4,5,6,7,8,9]  #prob not needed
  def initialize(size)
    @size = size
  end

  def draw_board()
    draw_line_breaks
    draw_row(1)
    draw_line_across
    draw_row(2)
    draw_line_across
    draw_row(3)
    draw_line_breaks
  end
  
  private
  def draw_row(row_number)
    raise "Invalid Row Number" if row_number > 3 || row_number < 1
    i = 0
    start_range = 0
    end_range = 2
    case row_number
    when 2
      start_range = 3
      end_range = 5
    when 3
      start_range = 6
      end_range = 8
    end
    #puts "start_range: #{start_range} and end_range: #{end_range}"
    @@positions_played[start_range..end_range].each {|value| 
      index = 2+(6*i)
      #puts "i: #{i}, line: #{@@line}, and index: #{index}, line.length: #{@@line.length}, and @@positions_played[start_range+i]: #{@@positions_played[start_range+i]}"
      case @@positions_played[start_range+i]
      when 1
        @@line[index] = "X"
      when 2
        @@line[index] = "O"
      end
      i+=1
    }
    puts @@line
  end
  def draw_line_breaks()
    puts "\n"
  end

  def draw_line_across()
    puts "-" * @@chars_across
  end

  def draw_column()
    puts " " * (@@chars_across/3) + "|" + " " * (@@chars_across/3) + "|"
  end

end


board = Board.new(3)
board.draw_board()