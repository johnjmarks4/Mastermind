require_relative 'game'
require_relative 'codemaker'
require_relative 'codebreaker'

puts "Welcome to Mastermind! What is your name?"
player_name = gets.chomp

my_game = Game.new("My game", player_name)

puts "Hello, #{player_name}! Would you like to play as codebreaker or codemaker?"
my_game.assign_role(gets.chomp)

player = my_game.player?
computer = my_game.computer?

winner = false 
turns = 0

if player.class == Codebreaker

  puts turns == 0 ? File.read("codebreaker_rules.txt") : nil

  while turns < 12 && winner == false

    code = computer.randomly_make_code
    guess = player.manually_guess(gets.chomp)

    if code == guess
      puts "You won! Congrats!"
      puts "You correctly guessed the code: #{code}!"
      break
    else
      my_game.compare_guess_to_code(guess, code)
      puts "Turn #{(turns + 1)}:"
      puts (my_game.display?).join(", ").inspect
    end

    turns += 1

    if turns == 12
      puts "Your turns are up! You lose!"
      puts "Here's what the code was: #{code}"
    end

  end
end

if player.class == Codemaker

  puts turns == 0 ? File.read("codemaker_rules.txt") : nil
  code = player.manually_make_code(gets.chomp)

  while turns < 12 && winner == false

    #display = my_game.display? #broken now?
    guess = computer.randomly_guess(my_game.display?)

    if my_game.winner?(computer, player)
      puts "Oh no! The computer correctly guessed your code #{code}! You've lost!"
      break
    else
      my_game.compare_guess_to_code(guess, code) #does this do anything?
      puts "Computer guess number #{(turns + 1)}:"
      puts (computer.guess?).join(", ").inspect
    end

    turns += 1

    if turns == 12
      puts "The computer wasn't able to guess your code!"
      puts "You won!"
    end

  end
end