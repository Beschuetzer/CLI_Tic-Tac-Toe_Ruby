class Board
  #0 = open, 1 = player 1, 2 = player 2
  @@positions_played = [0,0,0,0,0,0,0,0,0]    
  @@lines_before = 3
  @@chars_across = 17
  @@winner = ""
  @@is_a_winner = false
  @@spaces = 3
  @@line = " " * (@@chars_across/3) + "|" + " " * (@@chars_across/3) + "|" + " " * (@@chars_across/3)
  @@plays_available = [1,2,3,4,5,6,7,8,9] 

  def start
    #print instructions, get plays, and loop through until someone wins
  end

  def get_move(player)
    raise "Player must be 1 or 2" if !player.between?(1,2)
    begin                                      
      print "Player #{player}'s turn.  Available options are #{@@plays_available}: "
      desired_move = gets.chomp.to_i
      # puts "desired_move: #{desired_move} and @@plays_available: #{@@plays_available}"
      # puts "@@plays_available.include?(desired_move): #{!@@plays_available.include?(desired_move)}"
    end while !@@plays_available.any?{|play|play == desired_move}
    if player == 1
      @@positions_played[desired_move-1] = 1 

    else
      @@positions_played[desired_move-1] = 2
    end
    @@plays_available -= [desired_move]
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
    puts "#{@@winner} is the winner!" if @@is_a_winner
  end
  
  private
  def get_winner(iteration, row_multiplier = 1)
    puts "the winner is in @@positions_played[#{0+iteration*row_multiplier}]: "
    if @@positions_played[0+iteration*row_multiplier] == 1
      @@winner = "Player 1"
    else 
      @@winner = "Player 2"
    end
    @@is_a_winner = true
  end

  def evaluate_win()
    (0..2).each {|iteration|
      #column win
      if @@positions_played[0+iteration] != 0 && @@positions_played[0+iteration] == @@positions_played[3+iteration] && @@positions_played[3+iteration] == @@positions_played[6+iteration]
        get_winner(iteration)
        break
      #row win
      elsif @@positions_played[0+iteration*3] != 0 && @@positions_played[0+iteration*3] == @@positions_played[1+iteration*3] && @@positions_played[1+iteration*3] == @@positions_played[2+iteration*3]
        get_winner(iteration, 3)
        break
      end
    }
    #diagonal win (0,4,8) or (2.4,6)
    #puts "@@positions_played[0]: #{@@positions_played[0]}, @@positions_played[4]: #{@@positions_played[4]}, @@positions_played[8]: #{@@positions_played[8]}, "
    if @@positions_played[0] != 0 && @@positions_played[0] == @@positions_played[4] && @@positions_played[4] == @@positions_played[8]
      get_winner(0)
    elsif @@positions_played[2] != 0 && @@positions_played[2] == @@positions_played[4] && @@positions_played[4] == @@positions_played[6]
      get_winner(2)
    end
  end

  def draw_row(row_number)
    raise "Invalid Row Number" if !row_number.between?(1,3)
    i = 0
    case row_number
    when 1
      start_range = 0
      end_range = 2
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
      else
        @@line[index] = " "
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

#win conditions
# p1 = [1,1,1,0,0,0,0,0,0]    
# p2 = [0,0,0,1,1,1,0,0,0]    
# p3 = [0,0,0,0,0,0,1,1,1]    
# p4 = [1,0,0,1,0,0,1,0,0]    
# p5 = [0,1,0,0,1,0,0,1,0]    
# p6 = [0,0,1,0,0,1,0,0,1]    
# p7 = [1,0,0,0,1,0,0,0,1]    
# p8 = [0,0,1,0,1,0,1,0,0]   
# p9 = [2,2,2,0,0,0,0,0,0]    
# p10 = [0,0,0,2,2,2,0,0,0]    
# p11 = [0,0,0,0,0,0,2,2,2]    
# p12 = [2,0,0,2,0,0,2,0,0]    
# p13 = [0,2,0,0,2,0,0,2,0]    
# p14 = [0,0,2,0,0,2,0,0,2]    
# p15 = [2,0,0,0,2,0,0,0,2]    
# p16 = [0,0,2,0,2,0,2,0,0]   
# win_conditions = [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16]
# win_conditions.each{|p|
#   board = Board.new(p)
#   board.draw_board()
# }
board = Board.new()
board.draw_board()
(1..4).each{|i|
  board.get_move(1)
  board.draw_board()
  board.get_move(2)
  board.draw_board()
}