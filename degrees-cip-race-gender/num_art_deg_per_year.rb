require "json"
puts '['

$cips = {}
File.open("2007-keys-parsed.txt","r").each_with_index do |line,i|
  line = line.split('|')
  $cips[line[1].to_s.split('.').join] = line[0]
end
puts $cips

# by subdepartment
def extract(year,file,terms)
  puts '{"year": '+year.to_s+','
  disc = {}
  keys = nil
  File.open(file,"r").each_with_index do |line,i|
    line =  line.chomp.split(',')
    keys = line if i == 0
    cip = 1
    cip = 2 if (year > 1994 && year < 1998) || year == 2001 || year == 2004
    if year > 1986
      dept = line[cip].split('"')[1]
      is_art = dept[0..2] == '50.' if dept
      is_art = false if !dept # dumb but this was erroring
    else
      dept = line[cip]
      is_art = dept.to_i >= 500000 && dept.to_i < 510000
    end

    if is_art
      cip_code = dept.to_s.split('.').join
      department = $cips[cip_code]
      department ||= ''
      disc[department] = 0 if disc[department].nil?
      terms.each do |term|
        i = keys.find_index(term)
        disc[department] += line[i].to_i
      end
    end
  end
  puts JSON.generate(disc)
  puts '},'
end

extract(1984,'data/c1984_cip.csv',['crace15',  'crace16'])
extract(1985,'data/c1985_re.csv', ['crace15',  'crace16'])
extract(1986,'data/c1986_cip.csv',['crace15',  'crace16'])
extract(1987,'data/c1987_re.csv', ['crace15',  'crace16'])
extract(1988,'data/c1988_cip.csv',['crace15',  'crace16'])
extract(1989,'data/c1989_re.csv', ['crace15',  'crace16'])
extract(1990,'data/c8990re.csv',  ['crace15',  'crace16'])
extract(1991,'data/c1991_re.csv', ['crace15',  'crace16'])
extract(1992,'data/c1992_re.csv', ['crace15',  'crace16'])
extract(1993,'data/c1993_re.csv', ['crace15',  'crace16'])
extract(1994,'data/c1994_re.csv', ['crace15',  'crace16'])
extract(1995,'data/c9495_a.csv',  ['crace15',  'crace16'])
extract(1996,'data/c9596_a.csv',  ['crace15',  'crace16'])
extract(1997,'data/c9697_a.csv',  ['crace15',  'crace16'])
extract(1998,'data/c9798_a.csv',  ['crace15',  'crace16'])
extract(1999,'data/c9899_a.csv',  ['crace15',  'crace16'])
extract(2000,'data/c2000_a.csv',  ['crace15',  'crace16'])
extract(2001,'data/c2001_a.csv',  ['crace15',  'crace16'])
extract(2002,'data/c2002_a.csv',  ['CRACE15',  'CRACE16'])
extract(2003,'data/c2003_a.csv',  ['crace15',  'crace16'])
extract(2004,'data/c2004_a.csv',  ['crace15',  'crace16'])
extract(2005,'data/c2005_a.csv',  ['crace15',  'crace16'])
extract(2006,'data/c2006_a.csv',  ['crace15',  'crace16'])
extract(2007,'data/c2007_a.csv',  ['crace15',  'crace16'])
extract(2008,'data/c2008_a.csv',  ['XCTOTALM', 'XCTOTALW'])
extract(2009,'data/c2009_a.csv',  ['XCTOTALM', 'XCTOTALW'])
extract(2010,'data/c2010_a.csv',  ['XCTOTALM', 'XCTOTALW'])
extract(2011,'data/c2011_a.csv',  ['XCTOTALM', 'XCTOTALW'])
extract(2012,'data/c2012_a.csv',  ['XCTOTALM', 'XCTOTALW'])

puts ']'
