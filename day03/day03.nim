import strutils

block solution01:

  let
    area: seq[string] = readFile("input03").split("\n")
    lineLen = area[0].len;
  var
    treeNum = 0
    currPos = (0,0)

  for i in countup(1, area.len-1):
    if currPos[1] > lineLen-1:
      currPos[1] = currPos[1] - lineLen
    case area[currPos[0]][currPos[1]]
    of '.':
      discard
    of '#':
      inc treeNum
    else: discard
    currPos[1] += 3
    currPos[0] += 1

  echo "Solution 01: ", treeNum

block solution02:
  proc calcTrees(yOffset: int, xOffset: int, fileName: string): int =
    let
      area: seq[string] = readFile("input03").split("\n")
      lineLen = area[0].len;
    var
      treeNum = 0
      currPos = (0,0)
  
    for i in countup(1, area.len-1):
      if currPos[1] > lineLen-1:
        currPos[1] = currPos[1] - lineLen
      if currPos[0] > area.len - 1:
        break
      case area[currPos[0]][currPos[1]]
      of '.':
        discard
      of '#':
        inc treeNum
      else: discard
      currPos[1] += xOffset
      currPos[0] += yOffset
    return treeNum

  echo "Solution 02: ",
         calcTrees(1,1,"input03") *
         calcTrees(1,3,"input03") *
         calcTrees(1,5,"input03") *
         calcTrees(1,7,"input03") *
         calcTrees(2,1,"input03")

