# Verifier Simulator
class VerifierSimulator
  def initialize
  end

  # Check if we have a valid user input
  def check(args)
    return true unless args.count != 1
    false
  end

  # Check if file is passed in
  def isFile(args)
    return false if args.empty?
    return false unless File.file?(args[0])
    true
  end

  # Perform hash calculation of string
  def hash(s)
    total = 0
    characters = s.split('')
    characters.each do |x|
      x = x.unpack('U*')[0]
      total += ((x**3000) + (x**x) - (3**x)) * (7**x)
    end
    (total % 65536).to_s(16)
  end

  # Check order of blocks
  def out_of_order(curr, prev)
    return true unless (curr - prev) == 1
    false
  end

  # Check the timestamp on each individula block
  # Return 1 if all is good, return 0 if not.
  def check_time(curr, prev)
    curr_time = curr.split('.')[0]
    prev_time = prev.split('.')[0]
    curr_nano = curr.split('.')[1]
    prev_nano = prev.split('.')[1]

    return 1 if (curr_time.to_i - prev_time.to_i) > 0

    if (curr_time.to_i - prev_time.to_i).zero?
      return 1 unless (curr_nano.to_i - prev_nano.to_i) <= 0
    end
    0
  end

  # Check hash
  def check_hash(calc, curr)
    return true unless calc.eql? curr
    false
  end

end
