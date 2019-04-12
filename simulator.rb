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
end
