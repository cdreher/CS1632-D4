# Verifier Simulator
class VerifierSimulator
  def initialize
  end

  # TO-DO: Create methods to check for validity of files, args, hash, times, etc.
  #
  #

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
    (total & 65536).to_s(16)
  end

  # Check order of blocks
  def out_of_order(curr, prev)
    return true unless (curr - prev) == 1
    false
  end

end
