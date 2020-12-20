 import strutils

type
  Direction = enum
    left up right down
  Ship = object
    x: int
    y: int
    direction: Direction

var ship: Ship = Ship(x: 0, y:0 , direction: right)

for line in lines "input12":
  let value = parseInt line[1 .. line.high]
  case line[0]
  of 'N': ship.y += value
  of 'S': ship.y -= value
  of 'E': ship.x += value
  of 'W': ship.x -= value
  of 'L':
    for _ in 1 .. (value div 90):
      if ship.direction == left:
        ship.direction = down
      else:
        dec(ship.direction)
  of 'R':
    for _ in 1 .. (value div 90):
      if ship.direction == down:
        ship.direction = left
      else:
        inc(ship.direction)
  of 'F':
    case ship.direction
    of left: ship.x -= value
    of up: ship.y += value
    of right: ship.x += value
    of down: ship.y -= value
  else:
    discard

echo "Solution 01: ", abs(ship.x) + abs(ship.y)
