# frozen_string_literal: true;

require 'pry'

class Tic
  def initialize
    puts "1. Player vs Computer \n2. Player vs Player"
    @@players = gets.chomp
    @@array = Array.new(9, 0)
  end
  
  def choose_sign
    puts "X or O?"
    loop do
      value = gets.chomp
      @@player1 = case value 
                  when "x" then "X"
                  when "o" then "O"
                  else value
                  end
      break if @@player1 == "X" || @@player1 == "O"  
      puts "Try again!" 
    end
    @@player2 = @@player1 == "X" ? "O" : "X"
  end

  def draw
    i = 0
    3.times do
      print "  " << String(@@array[i]) << "|" << String(@@array[i+=1]) << "|" << String(@@array[i+=1]) << "\n"  
      i+=1
      print "  " << "-+-+-\n" if i <= 7
    end
    @@array.each_with_index { |value,index| puts String(index) << ": " << String(value) if value == 0  } 
  end

  def who_goes_first
    puts "Who goes first?\n1.Player 1 \n2.Player 2"
    loop do
      @@first_to_play = gets.chomp
      break if @@first_to_play == "1" || @@first_to_play == "2"
      puts "Try again!"
    end
  end
  
  def check_board?(sign)
    if @@array[0] == sign && @@array[1] == sign && @@array[2] == sign
      return true
    elsif @@array[0] == sign && @@array[4] == sign && @@array[8] == sign
      return true
    elsif @@array[0] == sign && @@array[3] == sign && @@array[6] == sign
      return true
    elsif @@array[0] == sign && @@array[1] == sign && @@array[2] == sign
  end

  def play
    loop do

      if @@first_to_play == "1"
        puts "Player 1 Play: " 
        loop do
          choice = Integer(gets.chomp)
          if choice <= 8 && choice >= 0 && @@array[choice] == 0
            @@array[choice] = @@player1
	          draw
            break 
          end   
          puts "Try again!"
        end

        puts "Player 2 Play: " 
        loop do
          choice = Integer(gets.chomp)
          if choice <= 8 && choice >= 0 && @@array[choice] == 0
            @@array[choice] = @@player2
            draw
	          break 
          end    
          puts "Try again!"
        end
      else
        puts "Player 2 Play: " 
        loop do
          choice = Integer(gets.chomp)
          if choice <= 8 && choice >= 0 && @@array[choice] == 0
            @@array[choice] = @@player2
            draw
	    break
          end   
          puts "Try again!"
        end
	
        puts "Player 1 Play: " 
        loop do
          choice = Integer(gets.chomp)
          if choice <= 8 && choice >= 0 && @@array[choice] == 0
            @@array[choice] = @@player1
            draw
	          break
          end    
          puts "Try again!"
        end
      end
      binding.pry
      break unless @@array.include?(0)
    end
  end
end

robin = Tic.new
robin.choose_sign
robin.who_goes_first
robin.draw
robin.play


