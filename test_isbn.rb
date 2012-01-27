require 'isbn13'
require 'test/unit'

class ISBN13Test < Test::Unit::TestCase
  def test_format_1
    assert_isbn '978-9974-95-536-3'
  end

  def test_format_2
    assert_isbn '978-9974-95-519-6'
  end

  def test_format_3
    assert_isbn '978-950-07-3803-3'
  end

  def test_format_4
    assert_isbn '978-950-644-238-5'
  end

  def test_format_5
    assert_isbn '978-987-33-0311-1'
  end

  def test_format_6
    assert_isbn '978-84-323-1145-1'
  end

  def test_format_7
    assert_isbn '978-9974-1-0026-8'
  end

  def test_format_8
    assert_isbn '978-9974-32-269-1'
  end

  def test_valid
    assert_true ISBN13.valid?('9789974100268')
  end

  def test_valid_hyphens
    assert_true ISBN13.valid?('978-9974-32-269-1')
  end

  def test_invalid
    assert_false ISBN13.valid?('9999999999999')
  end

  def test_nil
    assert_false ISBN13.valid?(nil)
  end

  private

  def assert_isbn(isbn)
    assert_equal isbn, ISBN13.format(isbn.gsub('-', ''))
  end

  def assert_true(x)
    assert_equal true, x
  end

  def assert_false(x)
    assert_equal false, x
  end
end
