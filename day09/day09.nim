import strutils, sequtils

const preamble = 25

func check(num: int, range: seq[int]): (bool, int) =
  result = (true, num)
  var seen: seq[int]
  for i in range:
    if num - i in seen:
      return (false, num)
    seen.add i

proc solve01(filename: string): int =
  let file = readFile(filename).split("\n").map(parseInt)
  if file.len > preamble:
    for i in preamble ..< file.len:
      let res = check(file[i], file[i-preamble ..< i])
      if res[0]: return res[1]

proc solve02(filename: string, target: int): int =
  let file = readFile(filename).split("\n").map(parseInt)
  var
    li = 0
    hi = 1
    sum = file[li..hi].foldl(a + b)
  while(sum != target):
    if sum > target:
      inc li
    else:
      inc hi
    sum = file[li..hi].foldl(a + b)
    result = file[li..hi].min + file[li..hi].max

let sol01 = solve01("input09")
echo "Solution01: ", sol01
echo "Solution02: ", solve02("input09", sol01)

