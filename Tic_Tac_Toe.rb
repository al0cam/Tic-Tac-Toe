# frozen_string_literal: true;
require 'pry'

class Tic
  def initialize
    loop do
      puts "1. Player vs Computer \n2. Player vs Player"
      @@players = Integer(gets.chomp)
      break if @@players == 1 || @@players == 2
    end
    # @@array = Array.new(9, 0)
    @@array = Hash.new(' ')
    @@array['top_left'] = ' '
    @@array['top'] = ' '
    @@array['top_right'] = ' '
    @@array['mid_left'] = ' '
    @@array['mid'] = ' '
    @@array['mid_right'] = ' '
    @@array['bot_left'] = ' '
    @@array['bot'] = ' '
    @@array['bot_right'] = ' '
  end

  def choose_sign
    puts 'X or O?'
    loop do
      value = gets.chomp
      @@player1 = case value
                  when 'x' then 'X'
                  when 'o' then 'O'
                  else value
                  end
      break if @@player1 == 'X' || @@player1 == 'O'

      puts 'Try again!'
    end
    @@player2 = @@player1 == 'X' ? 'O' : 'X'
  end

  def draw
    print @@array['top_left'], ' ', @@array['top'], ' ', @@array['top_right'], "\n"
    puts '-+-+-'
    print @@array['mid_left'], ' ', @@array['mid'], ' ', @@array['mid_right'], "\n"
    puts '-+-+-'
    print @@array['bot_left'], ' ', @@array['bot'], ' ', @@array['bot_right'], "\n"
    puts 'Free positions: '
    # binding.pry
    @@array.each { |key, value| puts "#{key} : #{value}" if value == ' '}
    puts
  end

  def who_goes_first
    puts "Who goes first?\n1.Player 1 \n2.Player 2"
    loop do
      @@first_to_play = Integer(gets.chomp)
      break if @@first_to_play == 1 || @@first_to_play == 2

      puts 'Try again!'
    end
  end

  def check_board?(sign)
    return true if @@array['top_left'] == sign && @@array['top'] == sign && @@array['top_right'] == sign ||
                   @@array['mid_left'] == sign && @@array['mid'] == sign && @@array['mid_right'] == sign ||
                   @@array['bot_left'] == sign && @@array['bot'] == sign && @@array['bot_right'] == sign ||
                   @@array['top_left'] == sign && @@array['mid_left'] == sign && @@array['bot_left'] == sign ||
                   @@array['top'] == sign && @@array['mid'] == sign && @@array['bot'] == sign ||
                   @@array['top_right'] == sign && @@array['mid_right'] == sign && @@array['bot_right'] == sign ||
                   @@array['top_left'] == sign && @@array['mid'] == sign && @@array['bot_right'] == sign ||
                   @@array['top_right'] == sign && @@array['mid'] == sign && @@array['bot_left'] == sign
  end

  def board_full?
    @@array.each { |_index, value| return false if value == ' ' }
  end

  def play_human(player)
    print "Choose your position\n"
    loop do
      input = gets.chomp
      if @@array.include?(input) && @@array[input] == ' '
        @@array[input] = player
        break

      end
      print "Try again!\n"
    end
    draw
  end

  def play_computer
    print "Computers move\n"
    loop do
      value = rand(9)
      case_value = case value
                  when 0 then 'top_left'
                  when 1 then 'top'
                  when 2 then 'top_right'
                  when 3 then 'mid_left'
                  when 4 then 'mid'
                  when 5 then 'mid_right'
                  when 6 then 'bot_left'
                  when 7 then 'bot'
                  when 8 then 'bot_right'
                  end
      puts case_value
      if @@array[case_value] == ' '
        @@array[case_value] = @@player2
        break
      end
    end
    draw
  end

  def round
    loop do
      if @@players == 1
        if @@first_to_play == 1
          play_human(@@player1)
          break if board_full?

          play_computer
        else
          play_computer
          break if board_full?

          play_human(@@player1)
        end
      else
        if @@first_to_play == 1
          play_human(@@player1)
          break if board_full?

          play_human(@@player2)
        else
          play_human(@@player2)
          break if board_full?

          play_human(@@player1)
        end
      end
      if check_board?(@@player1)
        break

      elsif check_board?(@@player2)
        break

      end
    end
    if check_board?(@@player1)
      print "Player 1 is the winner!\n"
    elsif check_board?(@@player2)
      print "Player 2 is the winner!\n"
    elsif board_full?
      print "The board is full it\'s a draw!\n"
    end
  end
end

robin = Tic.new
robin.choose_sign
robin.who_goes_first
robin.draw
robin.round
