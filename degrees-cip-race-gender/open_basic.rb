# 
output = []
File.open("data/c2012_a.csv","r").each do |line|
  #output << line.split(',')[0]
  puts line.split(',')[0]
end
#puts output.inspect #.join(',')
