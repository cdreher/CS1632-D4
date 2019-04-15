# Verifier Simulator
class VerifierSimulator
  def initialize
    @people = {}
  end

  attr_accessor :people

  # Check if we have a valid user input
  def check(args)
    return true unless args.count != 1

    false
  end

  # Check if file is passed in
  def check_is_file(args)
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
    (total % 65_536).to_s(16)
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

    return 1 if (curr_time.to_i - prev_time.to_i).positive?

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

  # Print everthing out
  def print
    @people.delete('SYSTEM')
    @people.each do |key, value|
      puts key.to_s + ': ' + value.to_s + ' billcoins'
    end
  end

  # Check for negative value in billcoins
  def check_negatives
    @people.each do |key, value|
      if value.negative? && key != 'SYSTEM'
        puts 'Invalid block, address ' + key + ' has ' + value.to_s + ' billcoins!'
        puts 'BLOCKCHAIN INVALID'
        return true
      end
    end
    false
  end

  # Update billcoin transactions
  def update(person, billcoins)
    return nil unless person.is_a? String

    return nil unless billcoins.is_a? Numeric

    val_to_store = if @people.key?(person)
                     @people[person] + billcoins
                   else
                     billcoins
                   end
    @people[person] = val_to_store
  end

  # Handles transactions in transaction string from each line in file
  def complete_transactions(transaction)
    return false if transaction.is_a? Numeric

    return false unless transaction.include? '>'

    valid = false
    transactions = transaction.split(':')

    transactions.each do |trans|
      curr = trans.split('>')
      from = curr[0]
      to = curr[1].split('(')[0]
      billcoins = ((curr[1].split('(')[1])[0..-2]).to_i
      update(from, billcoins * -1)
      update(to, billcoins)
      valid = true
    end
    exit 1 if check_negatives
    valid
  end
end
