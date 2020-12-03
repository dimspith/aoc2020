import strutils, sequtils

# Read file into a seq of ints
let input = readFile("../dataset").split("\n").map(parseInt)

# Ints we have checked so far
var checked: seq[int]

# Solution 01
for i in input:
  if 2020 - i in checked:
    echo "Solution 01: ", (2020 - i) * i
  checked.add i

# Solution 02
for i, n in input:
  for j in input[(i+1) .. ^1]:
    for k in input[(i+2) .. ^1]:
      if n + j + k == 2020:
        echo "Solution 02: ", n*j*k
