require "json"
puts '['

def extract(year,file,terms)
  puts '{"year": '+year.to_s+','
  disc = {}
  File.open(file,"r").each_with_index do |line,i|
    line =  line.split(',')
    keys = line if i == 0

    if line[1].to_i >= 500000 && line[1].to_i < 510000
      disc[line[1]] = 0 if disc[line[1]].nil?
      terms.each do |term|
        i = keys.find_index(term)
        disc[line[1]] += line[i].to_i
      end
    end
  end
  puts JSON.generate(disc)
  puts '},'
end

extract(1984,'data/c1984_cip.csv',['crace15','crace16'])

puts '{"year": 1984,'
disc = {}
# unitid,cipcode,awlevel,crace15,crace16
File.open("data/c1984_cip.csv","r").each do |line|
  line =  line.split(',')
  if line[1].to_i >= 500000 && line[1].to_i < 510000
    disc[line[1]] = 0 if disc[line[1]].nil?
    disc[line[1]] += line[3].to_i
    disc[line[1]] += line[4].to_i
  end
end
puts JSON.generate(disc)
puts '},'

puts '{"year": 1985,'
disc = {}
# unitid,cipcode,awlevel,crace01,crace02,crace03,crace04,crace05,crace06,crace07,crace08,crace09,crace10,crace11,crace12,crace15,crace16,bal_m,bal_w
File.open("data/c1985_re.csv","r").each do |line|
  line =  line.split(',')
  if line[1].to_i >= 500000 && line[1].to_i < 510000
    disc[line[1]] = 0 if disc[line[1]].nil?
    disc[line[1]] += line[15].to_i
    disc[line[1]] += line[16].to_i
  end
end
puts JSON.generate(disc)
puts '},'

puts ']'
