require "test_helper"

class StringCalculatorTest < ActiveSupport::TestCase
  def setup
    @calculator = StringCalculator.new
  end

  test "returns 0 for empty string" do
    assert_equal 0, @calculator.add("")
  end

  test "returns the number itself for single number" do
    assert_equal 1, @calculator.add("1")
    assert_equal 5, @calculator.add("5")
  end

  test "returns sum of two numbers separated by comma" do
    assert_equal 6, @calculator.add("1,5")
    assert_equal 3, @calculator.add("1,2")
  end
end
