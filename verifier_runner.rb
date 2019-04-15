require_relative 'simulator'

# Runner class -> essentially run the Billcoin simulator
class VerifierRunner
  def initialize
    @previous_block = -1
    @previous_time = 0
    @previous_hash = '0'
    @sim = VerifierSimulator.new
  end

  # Run the program
  def run(args)
    if @sim.check(args) && @sim.check_is_file(args)
      filename = args[0]
      file = File.open filename
      parse(file)
      @sim.print
      file.close
    else
      puts 'File is invalid or missing.'
      exit 1
    end
  end

  # Parse billcoin input file
  def parse(file)
    while (line = file.gets)
      blockchain = line.split('|')
      s = blockchain[0] + '|' + blockchain[1] + '|' + blockchain[2] + '|' + blockchain[3]
      hashed = @sim.hash(s)

      check_order(blockchain)
      check_time(blockchain)
      check_hash(blockchain)

      if @sim.check_hash(hashed, blockchain[4].chomp)
        puts 'Line ' + blockchain[0] + ': String ' + s + ' hash set to '
        puts blockchain[4].chomp + ', should be ' + hashed
        puts 'BLOCKCHAIN INVALID'
        exit 1
      end

      @sim.complete_transactions(blockchain[2])
      @previous_hash = blockchain[4].chomp
      @previous_time = blockchain[3]
      @previous_block = blockchain[0]
    end
  end

  # Check if blocks are in order
  def check_order(blockchain)
    return unless @sim.out_of_order(blockchain[0].to_i, @previous_block.to_i)

    puts 'Invalid block number ' + blockchain[0] + ', should be ' + (@previous_block.to_i + 1).to_s
    exit 1
  end

  # Check the timestamp
  def check_time(blockchain)
    return unless @sim.check_time(blockchain[3].to_s, @previous_time.to_s) != 1 && @previous_time != 0

    puts 'Line ' + blockchain[0] + ': Previous timestamp ' + @previous_time.to_s
    puts ' >= new timestamp ' + blockchain[3].to_s
    exit 1
  end

  # Check previous hash
  def check_hash(blockchain)
    return unless @sim.check_hash(blockchain[1], @previous_hash) && @previous_hash != '0'

    puts 'Previous hash was ' + blockchain[1] + ', should be ' + @previous_hash.to_s
    puts 'BLOCKCHAIN INVALID'
    exit 1
  end
end
