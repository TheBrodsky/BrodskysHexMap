extends Node2D


@export var size: Vector2 = Vector2(40, 40)

@onready var origin: Marker2D = $Origin

func _ready() -> void:
	var hex: Hex = Hex.from_cube(Vector3i(0,0,0))
	var layout: HexLayout = HexLayout.new_layout(HexLayout.Orientation.POINTY as int, size, origin.position)
	var hexagon_drawn: Line2D = Line2D.new()
	hexagon_drawn.width = 3
	add_child(draw_hex(hex, layout, hexagon_drawn))


func draw_map() -> void:
	pass


func draw_hex(hex: Hex, layout: HexLayout, line: Line2D) -> Line2D:
	if line == null:
		line == Line2D.new()
	var corners: Array[Vector2] = layout.calc_polygon_corners(hex)
	for point in corners:
		line.add_point(point)
	line.add_point(corners[0]) # make sure it loops back on itself
	return line
