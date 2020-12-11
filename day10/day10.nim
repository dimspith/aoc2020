import strutils, sequtils, tables, algorithm

var file = readFile("input10").split("\n").map(parseInt).sorted()
file.add(file.max + 3)

proc solve01(file: seq[int]): int =
  var differences: CountTable[int]
  var currJoltage = 0
  while(currJoltage != file.max):
    for i in 1..3:
      if currJoltage+i in file:
        currJoltage += i
        differences.inc(i)
        break
  result += differences[1] * differences[3]

proc solve02(file: seq[int]): int =
  var paths = [0].toCountTable
  for num in file:
    paths[num] = paths[num-1] + paths[num-2] + paths[num-3]
  return paths[file[^1]]
  

echo "Solution 01: ", solve01(file)
echo "Solution 02: ", solve02(file)
