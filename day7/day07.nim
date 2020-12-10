import strutils, sequtils, sugar, tables, strscans, sets

type
  Bag = tuple[amount: int, color: string]
  Bags = seq[Bag]
  BagTable = Table[string, Bags]
  BagTableTuple = tuple[sol01: BagTable, sol02: BagTable]

proc createBagTable(filename: string): BagTableTuple =
  for line in lines filename:
    var
      count: int
      color1, color2: string
      bagsStr: string
      bags: Bags
    if scanf(line, "$+ bags contain $+", color1, bagsStr):
      result[1][color1] = @[]
      for bag in bagsStr.split(", "):
        if scanf(bag, "$i $+ bag", count, color2):
          bags.add((count, color2))
          result[0].mgetOrPut(color2, @[]).add (count, color1)
          result[1][color1].add (count, color2)

proc solve01(bagtab: BagTable): int =
  proc checkForBag(bagtab: BagTable, currBag: string, checked: var HashSet[string]) =
    if not bagtab.hasKey(currBag):
      return
    for bag in bagtab[currBag]:
      if not checked.containsOrIncl(bag[1]):
        checkForBag(bagtab, bag[1], checked)
  var checked: HashSet[string]
  checkForBag(bagtab, "shiny gold", checked)
  result = checked.len

proc solve02(bagtab: BagTable, currBag: string): int =
  if bagtab[currBag].len == 0: return 0
  for bag in bagtab[currBag]:
    result += bag[0] * (1 + solve02(bagtab, bag[1]))


let bagTable = createBagTable("input07")
echo solve01(bagTable[0])
echo solve02(bagTable[1], "shiny gold")
