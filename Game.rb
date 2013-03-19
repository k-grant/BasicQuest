class Game
  attr_reader :command

  def initialize(readin=STDIN, output=STDOUT)
    @input = readin
    @output = output
    @command_list = ["north", "east", "west", 
                  "south", "s", "e", "w",
                  "n", "North", "East", "South", "North", "quit"]
  end

  def get_command
    temp_command = @input.gets
    temp_command.chomp!
    if @command_list.index(temp_command) != nil then
     @command = temp_command
    end
  end

  def loop
    while @command != "quit"
      get_command
      puts @command      
    end
  end
end

