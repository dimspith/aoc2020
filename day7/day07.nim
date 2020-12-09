import strutils, sequtils, sugar, tables, strscans, sets

type
  Bag = tuple[amount: int, color: string]
  Bags = seq[Bag]
  BagTable = Table[string, Bags]
  # Babags = seq[Babag]

proc createBagTable(filename: string): BagTable =
  for line in lines filename:
    var
      count: int
      color1, color2: string
      bagsStr: string
      bags: Bags
    if scanf(line, "$+ bags contain $+", color1, bagsStr):
      for bag in bagsStr.split(", "):
        if scanf(bag, "$i $+ bag", count, color2):
          bags.add((count, color2))
          result.mgetOrPut(color2, @[]).add (count, color1)

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
  echo $checked

let bagTable = createBagTable("input07")
echo solve01(bagTable)
