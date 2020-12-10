import strutils

type
  Operation = tuple[op: string, val: int]
  OperationList = seq[Operation]

proc parseFile(file: string): OperationList =
  for line in lines file:
    let pair = line.split()
    result.add (pair[0], pair[1].parseInt)

proc solve01(cmds: OperationList): (bool, int) =
  result[0] = false
  var
    i = 0
    offset: int
    seen: seq[int] 

  while(true):
    if i in seen:
      return
    if i >= cmds.len:
      result[0] = true
      return

    seen.add(i)
    offset = 1
    case cmds[i].op
    of "acc":
      result[1] += cmds[i].val
    of "jmp":
      offset = cmds[i].val
    else:
      discard
    i += offset

func solve02(cmds: OperationList): int =
  func swap(cmd: var Operation) =
    if cmd.op == "jmp":
      cmd.op = "nop"
    elif cmd.op == "nop":
      cmd.op = "jmp"
  var cmdCopy = cmds
  for i, cmd in cmds:
    if cmd.op in @["jmp", "nop"]:
      swap(cmdCopy[i])
      let res = solve01(cmdCopy)
      if res[0]:
        return res[1]
      swap(cmdCopy[i])

let file = parseFile("input08")
echo "Solution01: ", solve01(file)[1]
echo "Solution02: ", solve02(file)
