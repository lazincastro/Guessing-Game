# Guessing Game
# Refactored version
# Original author: Lazaro "CachorroDoido" Castro
# Refactored: 2026

MAX_ATTEMPTS = 5
INITIAL_SCORE = 1000

def welcome
  system("clear") || system("cls")

  puts "=================================="
  puts "        🎯 GUESSING GAME 🎯"
  puts "=================================="
  print "What's your name? "
  gets.strip.capitalize
end

def choose_level
  puts "\nChoose difficulty level:"
  puts "1 - Easy (1..10)"
  puts "2 - Normal (1..60)"
  puts "3 - Hard (1..100)"
  puts "4 - Insane (1..150)"
  puts "5 - God Mode (1..200)"

  level = nil
  loop do
    print "Level: "
    level = gets.to_i
    break if (1..5).include?(level)
    puts "Invalid level. Choose between 1 and 5."
  end

  level
end

def max_number_for(level)
  case level
  when 1 then 10
  when 2 then 60
  when 3 then 100
  when 4 then 150
  else 200
  end
end

def get_valid_number(prompt)
  loop do
    print prompt
    input = gets.strip
    return input.to_i if input.match?(/^\d+$/)
    puts "Please enter a valid number."
  end
end

def show_hint(secret, guess)
  if guess < secret
    puts "⬆ The secret number is GREATER!"
  elsif guess > secret
    puts "⬇ The secret number is LOWER!"
  end
end

def calculate_score(score, guess, secret)
  difference = (guess - secret).abs
  score - (difference * 2)
end

def play(name)
  level = choose_level
  max = max_number_for(level)
  secret = rand(1..max)
  score = INITIAL_SCORE
  guesses = []

  puts "\nI'm thinking of a number between 1 and #{max}..."

  MAX_ATTEMPTS.times do |attempt|
    puts "\nAttempt #{attempt + 1} of #{MAX_ATTEMPTS}"
    puts "Previous guesses: #{guesses.join(', ')}" unless guesses.empty?

    guess = get_valid_number("Your guess: ")
    guesses << guess

    # Easter egg 😎
    if name.upcase == "LAZARO"
      puts "Developer privilege activated 😎"
      you_won
      return
    end

    if guess == secret
      you_won
      puts "Final score: #{score.round}"
      return
    end

    show_hint(secret, guess)
    score = calculate_score(score, guess, secret)

    if attempt == MAX_ATTEMPTS - 1
      puts "\nLast chance!"
      final_guess = get_valid_number("Final guess: ")
      if final_guess == secret
        you_won
      else
        you_lose(secret)
      end
    end
  end
end

def you_won
  puts "\n🏆 YOU WON!!! 🏆"
end

def you_lose(secret)
  puts "\n💀 YOU LOSE!"
  puts "The secret number was #{secret}"
end

def play_again?
  print "\nPlay again? (Y/N): "
  gets.strip.upcase != "N"
end

# ===========================
# MAIN LOOP
# ===========================

player_name = welcome

loop do
  play(player_name)
  break unless play_again?
end

puts "\nThanks for playing! 👋"
