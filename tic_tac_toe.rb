class Board
  #0 = open, 1 = player 1, 2 = player 2
  @@positions_played = [1,2,0,1,2,2,1,1,0]    
  @@lines_before = 3
  @@chars_across = 17
  @@winner = false
  @@spaces = 3
  @@line = " " * (@@chars_across/3) + "|" + " " * (@@chars_across/3) + "|" + " " * (@@chars_across/3)
  @@plays_available = [1,2,3,4,5,6,7,8,9] 
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
    evaluate_win
  end
  
  private
  def get_winner(iteration)
    if positions_played[0+iteration] == 1
      winner = "Player 1"
    else 
      winner = "Player 2"
    end
    winner
  end

  def evaluate_win()
    i=0
    (0..2).each {|iteration|
      #column win
      if positions_played[0+iteration] != 0 && positions_played[0+iteration] == positions_played[3+iteration] && positions_played[3+iteration] == positions_played[6+iteration]
        winner = get_winner(iteration)
        break
      #row win
      else if positions_played[0+iteration*3] != 0 && positions_played[0+iteration*3] == positions_played[1+iteration*3] && positions_played[1+iteration*3] == positions_played[2+iteration*3]
        winner = get_winner(iteration)
        break
    }
      #diagonal win (0,4,8) or (2.4,6)
    if positions_played[0] != 0 && positions_played[0] == positions_played[4] && positions_played[4] == positions_played[8]
      winner = get_winner(0)
      break
    else if positions_played[2] != 0 && positions_played[2] == positions_played[4] && positions_played[4] == positions_played[6]
      winner = get_winner(2)
      break
    end
    winner
  end

  def draw_row(row_number)
    raise "Invalid Row Number" if !row_number.between?(1,3)
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
      raise "Invalid Value #{@@positions_played[start_range+i]}.  Must be either 0, 1, or 2" if !@@positions_played[start_range+i].between?(0,2)
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
end


board = Board.new(3)
board.draw_board()