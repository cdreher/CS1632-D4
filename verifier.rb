require 'flamegraph'

require_relative 'verifier_runner.rb'

# Begin execution
Flamegraph.generate('flamegraph.html') do
  runner = VerifierRunner.new
  runner.run(ARGV)
end
