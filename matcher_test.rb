require 'pry'

require 'minitest/autorun'
require 'minitest/pride'

require './matcher'


class SnailTest < Minitest::Test

  def setup
    @good   = "[123]{a(b)}"
    # @bad11  = "[123{a(b)}"
  end


  def test_it_exists
    assert_instance_of Matcher, Matcher.new(@good)
    assert_instance_of Matcher, Matcher.new(@bad)
  end

  def test_it_knows_when_all_brackets_are_matched
    matcher  = Matcher.new(@good)
    expected = true
    actual   = matcher.assess
    assert_equal(expected, actual)
  end


  # ---- Square -----

  def test_it_catches_missing_open_square_bracket
    bad      = "123]{a(b)}"
    matcher  = Matcher.new(bad)
    expected = false
    actual   = matcher.assess
    assert_equal(expected, actual)
  end

  def test_it_catches_missing_closing_square_bracket
    bad      = "[123{a(b)}"
    matcher  = Matcher.new(bad)
    expected = false
    actual   = matcher.assess
    assert_equal(expected, actual)
  end


  # ---- Curly -----

  def test_it_catches_missing_open_curly_bracket
    bad      = "[123]a(b)}"
    matcher  = Matcher.new(bad)
    expected = false
    actual   = matcher.assess
    assert_equal(expected, actual)
  end

  def test_it_catches_missing_closing_curly_bracket
    bad      = "[123]{a(b)"
    matcher  = Matcher.new(bad)
    expected = false
    actual   = matcher.assess
    assert_equal(expected, actual)
  end


  # ---- Parens -----

  def test_it_catches_missing_open_paren_bracket
    bad      = "[123]{ab)}"
    matcher  = Matcher.new(bad)
    expected = false
    actual   = matcher.assess
    assert_equal(expected, actual)
  end

  def test_it_catches_missing_closing_paren_bracket
    bad      = "[123]{a(b}"
    matcher  = Matcher.new(bad)
    expected = false
    actual   = matcher.assess
    assert_equal(expected, actual)
  end


  # ---- None -----

  def test_it_works_with_no_brackets
    good     = "123ab"
    matcher  = Matcher.new(good)
    expected = true
    actual   = matcher.assess
    assert_equal(expected, actual)
  end


  # ---- Mixed -----

  def test_it_works_with_unmatched_and_mixed_brackets
    bad      = "{{{ ]]]"
    matcher  = Matcher.new(bad)
    expected = false
    actual   = matcher.assess
    assert_equal(expected, actual)
  end


  # ---- Mixed -----

  def test_assignment_spec_examples
    str1 = '{}';         exp1 = true;  act1 = Matcher.new(str1).assess
    str2 = '{(';         exp2 = false; act2 = Matcher.new(str2).assess
    str3 = '{()}';       exp3 = true;  act3 = Matcher.new(str3).assess
    str4 = '{[)][]}';    exp4 = false; act4 = Matcher.new(str4).assess
    str5 = ']';          exp5 = false; act5 = Matcher.new(str5).assess
    str6 = '({[]}{[]})'; exp6 = true;  act6 = Matcher.new(str6).assess

    assert_equal(exp1, act1)
    assert_equal(exp2, act2)
    assert_equal(exp3, act3)
    assert_equal(exp4, act4)
    assert_equal(exp5, act5)
    assert_equal(exp6, act6)
  end


end
