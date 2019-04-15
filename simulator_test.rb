require 'simplecov'
SimpleCov.start
require_relative 'simulator'
require 'minitest/autorun'

# Class to test verifier
class SimulatorTest < Minitest::Test
  # UNIT TESTS FOR METHOD check(args)
  # Equivalance classes:
  # args = [] -> returns false
  # args= [filename] -> returns true

  # Test that no args fails
  def test_check_1
    sim = VerifierSimulator.new
    assert_equal false, sim.check([])
  end

  # Test that two args fails
  def test_check_2
    sim = VerifierSimulator.new
    assert_equal false, sim.check(%w[test test2])
  end

  # test that one arg passes
  def test_check_3
    sim = VerifierSimulator.new
    assert_equal true, sim.check(['test'])
  end

  # UNIT TESTS FOR METHOD if_file(args)
  # Equivalance classes:
  # If args[0] is a file -> returns true
  # If args[0] is not a file -> returns false

  # Test that args is not a file
  def test_invalid_file
    sim = VerifierSimulator.new
    assert_equal false, sim.if_file(['test'])
  end

  # Tests args as an empty array
  def test_invalid_file2
    sim = VerifierSimulator.new
    assert_equal false, sim.if_file([])
  end

  # test multiple args in array
  def test_invalid_file3
    sim = VerifierSimulator.new
    assert_equal false, sim.if_file(%w[test test2])
  end

  # Tests valid file
  def test_valid_file
    sim = VerifierSimulator.new
    assert_equal true, sim.if_file(['sample.txt'])
  end

  # UNIT TESTS FOR METHOD hash(hash_str)
  # Equivalence classes:
  # If a valid blockchain is passed this should hash
  # the block and return the correct hash

  # Test valid hash
  def test_hash_valid
    sim = VerifierSimulator.new
    assert_equal 'f896', sim.hash('bill')
  end

  # UNIT TESTS FOR METHOD check_hash(hash, curr_hash)
  # Equivalence classes:
  # If hash == curr_hash -> return true
  # If hash != curr_hash -> return false

  # Test check_hash method for when valid input is equal
  def test_check_hash_fails
    sim = VerifierSimulator.new
    assert_equal false, sim.check_hash('2d7f', '2d7f')
  end

  # Test check_hash method for when valid input is not equal
  def test_check_hash_pass
    sim = VerifierSimulator.new
    assert_equal true, sim.check_hash('1c12', '1c24')
  end

  # UNIT TESTS FOR METHOD update(person, billcoins])
  # Equivalance classes:
  # If person is a string and billcoins =is a number -> return person with updated
  # billcoin value
  # If person != string and billcoins != number -> returns nil

  # Tests two strings
  def test_invalid_update
    sim = VerifierSimulator.new
    assert_nil sim.update('Mike', 'test')
  end

  # Tests two numbers
  def test_invalid_update2
    sim = VerifierSimulator.new
    assert_nil sim.update(1, 2)
  end

  # Tests correct input
  def test_valid_update
    sim = VerifierSimulator.new
    sim.update('Mike', 22)
    assert_equal 22, sim.people['Mike']
  end

  # UNIT TESTS FOR METHOD complete_transactions(trans_str)
  # If trans_str is valid and transaction can be completed return true
  # Otherwise return false

  # Test valid trans_str that can be completed
  def test_valid_transaction
    sim = VerifierSimulator.new
    assert_equal true, sim.complete_transactions('SYSTEM>Mike(100)')
  end

  # Tests number as trans_str
  def test_invalid_transaction1
    sim = VerifierSimulator.new
    assert_equal false, sim.complete_transactions(100)
  end

  # Tests empty string
  def test_invalid_transaction2
    sim = VerifierSimulator.new
    assert_equal false, sim.complete_transactions('')
  end

  # Tests invalid string
  def test_invalid_transaction3
    sim = VerifierSimulator.new
    assert_equal false, sim.complete_transactions('test')
  end

  # UNIT TESTS FOR METHOD check_time(curr_time, prev_time)
  # Equivalence classes:
  # If curr_time > prev_time -> return 1
  # If curr_time <= prev_time -> return 0

  # Tests curr time > prev_time
  def test_valid_time
    sim = VerifierSimulator.new
    assert_equal 1, sim.check_time('1553184699.658215000', '1553184699.652449000')
  end

  # Tests curr time < prev_time
  def test_invalid_time1
    sim = VerifierSimulator.new
    assert_equal 0, sim.check_time('1553184699.652449000', '1553184699.658215000')
  end

  # UNIT TESTS FOR METHOD out_of_order(curr_block, prev_block)
  # Equivalence classes:
  # If prev_block and curr_block - 1 -> return true, etc.
  # Otherwise -> returns false

  # Tests invalid order
  def test_out_of_order_invalid
    sim = VerifierSimulator.new
    assert_equal false, sim.out_of_order(100, 99)
  end

  # Tests Valid order
  def test_out_of_order_valid
    sim = VerifierSimulator.new
    assert_equal true, sim.out_of_order(99, 100)
  end

  # UNIT TESTS FOR METHOD print(curr_block, prev_block)
  # Equivalence classes:
  # If @person contains values print them
  # otherwise do not print

  # Test Empty @person
  def test_print_invalid
    sim = VerifierSimulator.new
    @str = '4|e51a|SYSTEM>959441(100)|1553188773.563329000|7998'
    assert_output(//) { sim.print }
  end

  # UNIT TESTS FOR METHOD check_negatives(curr_block, prev_block)
  # Equivalence classes:

  # Tests
  def check_negatives_test
    @key = Minitest::Mock.new('mock')
    @value = Minitest::Mock.new(-1)
    assert_equal true, sim.check_negatives
  end
end
