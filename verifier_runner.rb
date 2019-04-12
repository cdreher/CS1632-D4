require_relative 'simulator.rb'

# Runner class -> essentially run the Billcoin simulator
class VerifierRunner
  def initialize
    @sim = VerifierSimulator.new
  end

  # Run the program
  def run(args)
    if @sim.check(args) && @sim.isFile(args)
      filename = args[0]
      file = File.open filename
      puts "File IS VALID"
      file.close
    else
      puts 'File is invalid.'
      exit 1
    end
  end

end
