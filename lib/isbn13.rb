require 'version'

class ISBNError < StandardError
end

module ISBN13
  # based on ruby example on http://en.wikipedia.org/wiki/International_Standard_Book_Number#ISBN-13
  def self.valid?(isbn)
    return false if isbn.nil?

    isbn = isbn.gsub(/-/, '')
    return false unless valid_form?(isbn)

    sum = 0
    13.times { |i| sum += i.modulo(2)==0 ? isbn[i].to_i : isbn[i].to_i*3 }
    0 == sum.modulo(10)
  end

  def self.format(isbn)
    raise ISBNError.new("#{isbn} is not a proper ISBN13 number") unless valid_form?(isbn)
    load

    breaks = [3]
    found = false
    size = nil
    @ranges.keys.max.to_s.size.downto(3) do |x|
      found = @ranges.has_key?(isbn[0, x].to_i)
      size = x
      break if found
    end
    raise ISBNError.new("group not found") unless found
    breaks << size - breaks.first

    data = @ranges[isbn[0, size].to_i]
    pub_size = nil
    found = false
    data[:min].upto(isbn.size - breaks.last) do |x|
      found = data[:ranges].any? { |range| range.cover?(isbn[size, x].to_i) }
      pub_size = x
      break if found
    end
    raise ISBNError.new("publisher not found") unless found
    breaks << pub_size

    breaks << isbn.size - breaks.reduce(&:+) - 1
    breaks << 1

    result = []
    idx = 0
    breaks.each do |x|
      result << isbn[idx, x]
      idx += x
    end

    result.join('-')
  end

  def self.ranges_path
    File.join(File.dirname(__FILE__), 'ranges.bin')
  end

  private

  def self.valid_form?(x); x =~ /^\d{13}$/; end

  def self.save(ranges, path=ranges_path)
    File.open(path, 'w') { |io| io.write Marshal.dump(ranges) }
  end

  def self.load
    return unless @ranges.nil?

    if File.exist?(ranges_path)
      @ranges = File.open(ranges_path) { |io| Marshal.restore(io) }
    else
      raise "#{ranges_path} not found, run make_ranges.rb"
    end
  end
end


if $0 == __FILE__
  isbn = ARGV.shift
  if isbn.nil?
    puts "usage: #{$0} <isbn>"
    exit 1
  end
  puts ISBN13.format(isbn)
end

