extends Node2D

@export var map_size: int = 3
@export var tile_size: Vector2 = Vector2(40, 40)
@export var orientation: HexLayout.Orientation = HexLayout.Orientation.FLAT
@export var primary_axes: HexMap.PrimaryAxes = HexMap.PrimaryAxes.QR
@export var line_style: Line2D

@onready var origin: Marker2D = $Origin


func _ready() -> void:
	var map: HexMap = TriangleHexMap.new_map(map_size, TriangleHexMap.Direction.RIGHT_OR_UP, primary_axes)
	var layout: HexLayout = HexLayout.new_layout(orientation, tile_size, origin.position)
	
	var drawn_hexes: Array[Line2D] = HexDraw.draw_map(map, layout, line_style)
	for hex in drawn_hexes:
		add_child(hex)
