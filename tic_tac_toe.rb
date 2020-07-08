class Board
  #0 = open, 1 = player 1, 2 = player 2
  @@positions_played = [0,0,0,0,0,0,0,0,0]    
  @lines_before = 3
  @chars_across = 23
  positions_available = [1,2,3,4,5,6,7,8,9]  #prob not needed
  def initialize(size)
    @size = size
  end

  def draw_row_one(values=[0,0,0])
    #quadrant_one = " "


    draw_x()

  end

  def draw_x()
    spaces = 2
    print " " * spaces + "\\/"
    puts " " * spaces + "/\\"
  end

  def draw_blank_board()
    draw_x
    draw_line_breaks
    2.times {draw_column}
    draw_line_across
    2.times {draw_column}
    draw_line_across
    2.times {draw_column}
    draw_line_breaks
  end
  
  private
  def draw_line_breaks()
    puts "\n"
  end

  def draw_line_across()
    puts "-" * 23
  end

  def draw_column()
    puts " " * (23/3) + "|" + " " * (23/3) + "|"
  end

end


board = Board.new(3)
board.draw_blank_board()