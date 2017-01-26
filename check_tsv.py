import sys
lengths=[]
for line in open(sys.argv[1]):
  lengths.append(len(line.split('\t')))
for index,length in enumerate(lengths[1:]):
  if length!=lengths[0]:
    print 'Line',index+1,'has different number of attributes!'
