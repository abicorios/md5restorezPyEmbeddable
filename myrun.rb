def myrun(mycmd)
IO.popen(mycmd).each do |l|
puts l
end
end
