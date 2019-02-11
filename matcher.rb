

class Matcher

  def initialize(sequence)
    @sequence = sequence

    # @starter  = [ '[', '{', '(']
    # @ender    = [ ']', '}', ')']

    @set = {
      '[': 0,
      '{': 0,
      '(': 0,
      ']': 0,
      '}': 0,
      ')': 0
    }


  end

  # returns T /  F

  def assess
    count_brackets
    puts compare_brackets
  end


  def count_brackets
    keys    = @set.keys
    letters = @sequence.chars
    letters.each { |l| @set[l] += 1 if keys.include?(l) }
  end


  def compare_brackets
    a = @set[ '[' ] - @set[ ']' ]
    b = @set[ '{' ] - @set[ '}' ]
    c = @set[ '(' ] - @set[ ')' ]

    sum = [a, b, c].sum
    sum == 0 ? true : false
  end


end
