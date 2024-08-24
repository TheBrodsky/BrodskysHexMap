extends HexMap
class_name HexagonalHexMap


var radius: int ## number of hexes from the center to expand the map


static func new_map(radius: int) -> HexagonalHexMap:
	var hex_map: HexagonalHexMap = HexagonalHexMap.new()
	hex_map.radius = radius
	hex_map._populate_map()
	return hex_map


## For Hexagonal maps, the map area is defined by 6 half-planes (1 for each side of the hexagon-shaped map).
## We pair these half-planes up by axis (3 axies in cube coordinates: q,r,s). A pair is the half-planes on opposite sides.
## We only actually care about 2 of these pairs because the 3rd can be inferred by converting from axial to cube coordinates.
## In the end, each hexagon satisfies each of the 6 inequalities represented by the 6 half-planes
## (ie each hexagon lies within an area bound by all 6 half-planes).
func _populate_map() -> void:
	for q in range(-radius, radius+1): # -radius - radius, inclusive
		var r1: int = max(-radius, -q - radius)
		var r2: int = min(radius, -q + radius)
		for r in range(r1, r2+1): # r1 to r2, inclusive
			insert(Hex.from_axial(Vector2(q, r)))
