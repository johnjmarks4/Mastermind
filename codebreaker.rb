class Codebreaker
  attr_accessor :guess
  
  def initialize(name)
    @name = name
    @available_colors = ["blue", "green", "orange", "purple", "red", "yellow"]
    @guess = []
  end
  
  def randomly_guess(display)
    i = 0

    if @guess == []
      4.times do @guess << @available_colors[rand(5)]; end
    end

    @guess.map do |color|
      if display[i] == "white" && @guess.count(display[i]) == 1 # if not already "a black"...
        @guess[rand(4)] = @guess[i] #...then reuse color in random location
      else
        @guess[i] = @available_colors[rand(5)]
      end
    i += 1
    end
    
    @guess
  end
  
  def manually_guess(input)
    input.gsub!("  ", " ").downcase!
    input.gsub!("  ", " ")
    input.gsub!(", ", " ")
    input.gsub!(",", " ")
    @guess = input.split(" ")
  end
  
  def guess?
    return @guess
  end
  
end