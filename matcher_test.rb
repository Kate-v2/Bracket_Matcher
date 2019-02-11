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

  def test_it_works_with_no_brackets
    good     = "123ab"
    matcher  = Matcher.new(good)
    expected = true
    actual   = matcher.assess
    assert_equal(expected, actual)
  end


end
