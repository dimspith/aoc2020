import strutils, re, tables

block solutions:
  var
    passport: string
    sol01: int
    sol02: int
  let fieldRules = { "ecl": re"(amb|blu|brn|gry|grn|hzl|oth)",
                     "pid": re"[0-9]{9}",
                     "eyr": re"(202[0-9]|2030)",
                     "hcl": re"#[a-f0-9]{6}",
                     "byr": re"19[2-9][0-9]|200[0-2]",
                     "iyr": re"(201[0-9]|2020)",
                     "hgt": re"((1[5-8][0-9]|19[0-3])cm|(59|6[0-9]|7[0-6])in)",}.toTable

  proc ifValidInc(pp: string) =
    var totalFields = 0
    var totalCorrectFields = 0
    for field in pp.split:
      if not field.isEmptyOrWhitespace:
        let fieldVals = field.split(":")
        for key, regex in fieldRules.pairs:
          if fieldVals[0] == key:
            inc totalFields
            if fieldVals[1] =~ regex:
              inc totalCorrectFields
    if totalFields == fieldRules.len:
      inc sol01
    if totalCorrectFields == fieldRules.len:
      inc sol02
  
  for line in lines "input04":
    if line.isEmptyOrWhitespace:
      ifValidInc(passport)
      passport = ""
    passport.add(line & '\n')

  echo "Solution 01: ", sol01
  echo "Solution 02: ", sol02

