extends HexMap
class_name TriangleHexMap


enum Direction {RIGHT_OR_UP, LEFT_OR_DOWN} ## right/left if flat, up/down if pointy

var side_length: int ## number of hexes that make up the side of the triangle
var direction: Direction


static func new_map(side_length: int, direction: Direction, axes: PrimaryAxes = PrimaryAxes.QR) -> TriangleHexMap:
	var hex_map: TriangleHexMap = TriangleHexMap.new()
	hex_map.side_length = side_length
	hex_map.direction = direction
	hex_map.axes = axes
	hex_map._populate_map()
	return hex_map


func _populate_map() -> void:
	if direction == Direction.RIGHT_OR_UP:
		for q in side_length:
			for r in side_length - q:
				insert(Hex.from_cube(map_to_axes(Vector2(q, r), axes)))
	else:
		for q in side_length:
			for r in range(side_length - q, side_length + 1):
				insert(Hex.from_cube(map_to_axes(Vector2(q, r), axes)))
