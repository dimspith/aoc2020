import strutils, sequtils, sugar, math, sets

block solutions:

  echo "Solution 01: ", readFile("input06").split("\n\n").map((x) => (x.deduplicate().filter((x) => x in {'a'..'z'}).len)).sum
  echo "Solution 02: ", readFile("input06").split("\n\n")
                                           .map((x) => x.splitLines
                                                .map((x) => x.toHashSet)
                                                .foldl(intersection(a, b)))
                                                .map((x) => x.len)
                                           .sum
