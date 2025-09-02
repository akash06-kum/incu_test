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

  test "handles any amount of numbers" do
    assert_equal 10, @calculator.add("1,2,3,4")
    assert_equal 15, @calculator.add("1,2,3,4,5")
    assert_equal 6, @calculator.add("1,2,3")
  end

  test "supports newlines as delimiters" do
    assert_equal 6, @calculator.add("1\n2,3")
    assert_equal 6, @calculator.add("1\n2\n3")
    assert_equal 10, @calculator.add("1,2\n3,4")
  end

  test "supports custom delimiters" do
    assert_equal 3, @calculator.add("//;\n1;2")
    assert_equal 6, @calculator.add("//|\n1|2|3")
    assert_equal 10, @calculator.add("//*\n1*2*3*4")
  end

  test "throws exception for single negative number" do
    exception = assert_raises(ArgumentError) { @calculator.add("1,-2,3") }
    assert_equal "negative numbers not allowed -2", exception.message
  end

  test "throws exception for multiple negative numbers" do
    exception = assert_raises(ArgumentError) { @calculator.add("1,-2,3,-4") }
    assert_equal "negative numbers not allowed -2,-4", exception.message
  end

  test "comprehensive test with custom delimiter and mixed scenarios" do
    assert_equal 6, @calculator.add("//;\n1;2;3")
    assert_equal 0, @calculator.add("")
    assert_equal 1, @calculator.add("1")
    assert_equal 15, @calculator.add("1,2,3,4,5")
    assert_equal 6, @calculator.add("1\n2,3")
  end
end
