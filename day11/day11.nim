import sequtils, sugar

type
  Tile = enum
    occupied, empty, floor
  TileSeq = seq[Tile]
  TileMap = seq[TileSeq]

const cachedDirections = [
    [-1, -1], [-1, 0], [-1, 1],
    [0,  -1],          [0,  1],
    [1,  -1], [1,  0], [1,  1],
  ]

iterator pairs2D(tilemap: TileMap): tuple[y: int, x: int, val: Tile] {.inline.} =
  for y in 0 ..< tilemap.len:
    for x in 0 ..< tilemap[y].len:
      yield(y, x, tilemap[y][x])          

proc readTileMap(filename: string): TileMap =
  for line in lines filename:
    var tilerow: TileSeq
    for tile in items line:
      case tile
      of '#':
        tilerow.add Tile.occupied
      of 'L':
        tilerow.add Tile.empty
      else:
        tilerow.add Tile.floor
    result.add tilerow

proc calcState(tile: Tile, adjTiles: TileSeq): tuple[changed: bool, newTile: Tile] =
  result = (false, tile)
  case tile
  of empty:
    if not (occupied in adjTiles):
      result = (true, occupied)
  of occupied:
    if adjTiles.count(occupied) >= 4:
      result = (true, empty)
  else:
    discard

proc applyRules(tilemap: TileMap): tuple[changed: bool, newTileMap: Tilemap] =
  result = (true, tilemap)
  let
    mapWidth = tilemap[0].len
    mapHeight = tilemap.len
  for y, x, val in pairs2D tilemap:
    var adjTiles: TileSeq
    for pos in cachedDirections.filter((offs) => (y+offs[0] in 0 ..< mapHeight) and (x+offs[1] in 0 ..< mapWidth)):
      adjTiles.add(tilemap[y+pos[0]][x+pos[1]])
    let tile = calcState(val, adjTiles)
    if tile.changed:
      result[1][y][x] = tile.newTile
  if tilemap == result[1]:
    result.changed = false
  
proc solve01(file: string): tuple[iterations: int, occupied: int] =
  var
    tilemap = readTileMap(file)
    res: tuple[changed: bool, newTileMap: Tilemap]
    numOccupied = 0
    iterations = 0
  while(true):
    res = applyRules(tilemap)
    if not res.changed:
      break
    tilemap = res.newTileMap
    iterations += 1
  for line in tilemap:
    numOccupied += line.count(occupied)
  return (iterations, numOccupied)

echo "Solution01: ", solve01("input11")
