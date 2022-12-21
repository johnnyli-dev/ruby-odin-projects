class MasterMind
  attr_reader :secret_code, :gameover, :round

  def initialize(player)
    @playername = player

    @secret_code = []
    @returns = {}
    @gameover = false
    @round = 1
  end

  def check_guess(guess)
    dupcode = @secret_code.clone.uniq
    dupguess = guess.clone.split('').uniq
    correct_spot = 0
    incorrect_spot = 0
    for i in 0..3 do
      if @secret_code[i] == guess[i]
        correct_spot += 1
        dupcode.delete(secret_code[i])
        dupguess.delete(secret_code[i])
      end
    end

    for i in dupcode do
      for x in dupguess do
        if i == x
          incorrect_spot += 1
        end
      end
    end

    if correct_spot == 4; @gameover = true end

    @round += 1

    @returns['Solid'] = correct_spot
    @returns['Holo'] = incorrect_spot

    @returns
  end

  def play
    chosen_role = @playername.arole
    if (chosen_role == 'B')
      code_breaker
    elsif (chosen_role == 'C')
      code_creator
    end
  end

  def code_breaker
    @secret_code = [(rand * 10).to_i.to_s, (rand * 10).to_i.to_s, (rand * 10).to_i.to_s,(rand * 10).to_i.to_s]
    while @round < 13 && !@gameover
      puts "Round ##{@round}:"
      guess = @playername.guess
      ans = check_guess(guess)
      puts "#{guess} - #{ans['Solid']}, #{ans['Holo']}"
    end
    if @gameover
      puts "Well done, you won in #{@round} rounds."
    else
      puts "Game over, you lost. The code was #{@secret_code.join}"
    end
  end

  def code_creator
    puts 'Select a secret code:'
    @secret_code = gets.chomp.split('')
    while @round < 13 && !@gameover
      puts "Round ##{@round}:"
      guess = (rand * 10_000).to_i.to_s.rjust(4, '0')
      ans = check_guess(guess)
      puts "#{guess} - #{ans['Solid']}, #{ans['Holo']}"
    end
    if @gameover
      puts "Well done, you won in #{@round} rounds."
    else
      puts "Game over, you lost. The code was #{@secret_code.join}"
    end
  end
end

# checks to make sure the string is all integers
def check_int(string)
  !string.scan(/\D/).empty?
end

# create player
class Player

  def initialize(playername)
    @playername = playername
    @role = ''
  end

  def guess
    puts 'Please enter a guessing combination of 4 numbers 0-6 inclusive: '
    guess = gets.chomp
    while guess.to_s.length != 4 || check_int(guess)
      puts 'Invalid input... '
      puts 'Please enter a guessing combination of 4 numbers 0-6 inclusive: '
      guess = gets.chomp
    end
    guess
  end

  def arole
    puts 'Do you want to player as the CodeBreaker or CodeCreator (B or C)'
    role = gets.chomp
    while !(role == 'B' || role == 'C')
      puts 'Invalid Input...'
      puts 'Do you want to player as the CodeBreaker or CodeCreator (B or C)'
      role = gets.chomp
    end
    role
  end
end

puts 'Enter Your Name: '
name = gets.chomp
player = Player.new(name)
game = MasterMind.new(player)
game.play
