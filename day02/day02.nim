import strscans, sequtils, strutils

block solution01:
  var
    minLet, maxLet: int
    letter: string
    password: string
    correctPasswords: int

  for line in lines "input02":
    if scanf(line, "$i-$i $+: $+$.", minLet, maxLet, letter, password):
      if password.count(letter) in minLet..maxLet:
        inc correctPasswords
      
  echo "Solution 01: ", correctPasswords
    
block solution02:
  var
    pos1, pos2: int
    letter: string
    password: string
    correctPasswords: int

  for line in lines "input02":
    if scanf(line, "$i-$i $+: $+$.", pos1, pos2, letter, password):
      if pos1 > password.len or pos2 > password.len:
        discard
      elif (password[pos1-1] == letter[0]) xor (password[pos2-1] == letter[0]):
        inc correctPasswords

  echo "Solution 02: ", correctPasswords
