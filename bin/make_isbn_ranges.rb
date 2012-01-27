$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'isbn13'
require 'mechanize'

# reading from a file is only intended for dev/test purposes
content = if File.exists?('isbncvt')
  puts 'reading ranges from local file'
  IO.read('isbncvt')
else
  puts 'downloading ranges from isbn-international.org'
  agent = Mechanize.new
  agent.user_agent_alias = 'Mac Safari'

  doc = agent.get('http://www.isbn-international.org/ia/isbncvt')

  doc.at('div#wrapper script').inner_html
end


puts 'parsing'
ranges = Hash.new
# ranges are defined in javascript as:
# ranges['xxx'][y][z] = 'first_value';
# ranges['xxx'][y][z+1] = 'last_value';
first = nil
content.each_line do |line|
  next unless line =~ /^\s*ranges\['(\d+)'\]\[\d+\]\[(\d+)\]*\s*=\s*'(\d+)'/
  data = [$1.to_i, $2, $3]

  if data[1] == '0'
    raise "first should be nil" unless first.nil?
    first = data.last
  else
    raise "first shouldnt be nil" if first.nil?

    ranges[data.first] ||= { :ranges => []}
    ranges[data.first][:ranges] << [first, data.last]
    first = nil
  end
end

ranges.values.each do |data|
  data[:min], data[:max] = data[:ranges].flatten.map(&:size).minmax

  data[:ranges].map! { |x| x.map!(&:to_i); Range.new(x.first, x.last) }
end


path = File.basename(ISBN13.ranges_path)
puts "creating " + path
ISBN13.save(ranges, path)

puts "\nyou must replace the file #{ISBN13.ranges_path} (inside the gem) with this new file"
