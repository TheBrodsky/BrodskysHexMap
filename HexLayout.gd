extends RefCounted
class_name HexLayout


## Hexlayout stores information relevant to hexes on a screen/map

enum Orientation {FLAT, POINTY}

var orient: Orientation
var size: Vector2 ## pixel width and height of the hex
var origin : Vector2 ## pixel coords of the center of the hex


static func new_layout(orientation: Orientation, size: Vector2, origin: Vector2) -> HexLayout:
	var layout: HexLayout = HexLayout.new()
	layout.orient = orientation
	layout.size = size
	layout.origin = origin
	return layout


## helper func that sums a Vector2 because I can't believe GDScript doesn't already have this???
static func sum_vec(vec: Vector2) -> int:
	return vec.x + vec.y


#region hex-pixel conversion
## returns the point in pixel space corresponding to the center of "hex"
func hex_to_pixel(hex: Hex) -> Vector2:
	var conversion_mat: Transform2D = _get_conversion_matrix(orient)
	var x: float = sum_vec(hex.get_axial() * conversion_mat.x) * size.x
	var y: float = sum_vec(hex.get_axial() * conversion_mat.y) * size.y
	return Vector2(x,y) + origin


## returns the point in hex space corresponding to the pixel position
func pixel_to_hex(pos: Vector2) -> Hex:
	var conversion_mat: Transform2D = _get_conversion_matrix(orient).affine_inverse()
	var adj_pos: Vector2 = (pos - origin)/size
	var q: float = sum_vec(adj_pos * conversion_mat.x)
	var r: float = sum_vec(adj_pos * conversion_mat.y)
	return Hex.from_fractional_cube(Vector3(q, r, -q -r))


func _get_conversion_matrix(orientation: Orientation) -> Transform2D:
	if orientation == Orientation.FLAT:
		return HexOrientation.FLAT_CONVERSION_MAT
	else:
		return HexOrientation.POINTY_CONVERSION_MAT
#endregion

#region draw hex
## returns a vector from the center of a hex to its corner
func calc_hex_corner_offset(corner: int) -> Vector2:
	var angle: float = _get_corner_angle(corner, orient)
	return Vector2(size.x * cos(angle), size.y * sin(angle))


## returns an array of the positions (in pixel space) of the corners of a hex
func calc_polygon_corners(hex: Hex) -> Array[Vector2]:
	var corners: Array[Vector2] = []
	var center: Vector2 = hex_to_pixel(hex)
	for i in 6:
		var offset: Vector2 = calc_hex_corner_offset(i)
		corners.append(center + offset)
	return corners


func _get_corner_angle(corner: int, orientation: Orientation) -> float:
	return _get_start_angle(orientation) + (TAU / 6 * corner)


func _get_start_angle(orientation: Orientation) -> float:
	if orientation == Orientation.FLAT:
		return HexOrientation.FLAT_START_ANGLE
	else:
		return HexOrientation.POINTY_START_ANGLE
#endregion
