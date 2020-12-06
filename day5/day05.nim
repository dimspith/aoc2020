import algorithm, parseutils, strutils

block solutions:
  var row, col: int
  var idList: seq[int]
  for line in lines "input05":
    discard line[0..6].replace('F', '0').replace('B', '1').parseBin(row)
    discard line[7..9].replace('L', '0').replace('R', '1').parseBin(col)
    idList.add((row*8) + col)

  echo "Solution 01: ", idList.max

  idList.sort()
  for id in idList:
    if (id+1 notin idList) and (id+2 in idList):
      echo "Solution 02: ", id+1
