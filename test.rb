mto='C:/restored'
if Dir.exist?mto then Dir.rmdir(mto) end
Dir.mkdir(mto)
mfrom='C:/Atari Jaguar/GoodJag (2.01)'
mcsv=Dir['C:/t/Atari*'][0]
`python md5restorezPyEmbeddable.py --myfrom #{mfrom} --myto #{mto} --mycsv #{mcsv}`
