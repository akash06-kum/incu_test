class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?
    
    delimiter, numbers = extract_delimiter_and_numbers(numbers)
    number_array = parse_numbers(numbers, delimiter)
    validate_no_negative_numbers(number_array)
    
    number_array.sum
  end

  private

  def extract_delimiter_and_numbers(input)
    if input.start_with?("//")
      delimiter_line, numbers = input.split("\n", 2)
      custom_delimiter = delimiter_line[2..-1]
      delimiter = /[,\n#{Regexp.escape(custom_delimiter)}]/
      [delimiter, numbers]
    else
      [/[,\n]/, input]
    end
  end

  def parse_numbers(numbers, delimiter)
    numbers.split(delimiter).map(&:to_i)
  end

  def validate_no_negative_numbers(number_array)
    negative_numbers = number_array.select { |n| n < 0 }
    
    if negative_numbers.any?
      raise ArgumentError, "negative numbers not allowed #{negative_numbers.join(',')}"
    end
  end
end
