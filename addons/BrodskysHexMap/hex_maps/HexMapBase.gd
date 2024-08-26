extends RefCounted
class_name HexMap


## The data structure that represents a tiling of hexagons.
## There are many different shapes of hexagon tilings, so this is only a base class.
##
## By default, this is just an unordered set of Hex objects.
## That is to say, the keys are Hex objects and the values are null.


# Becausae of the q+r+s=0 relationship, we usually only calculate 2 (q and r) and infer the third.
# For some map shapes, which two you pick changes how the map looks, assuming you're using the same
# code to generate the values. So this is effectively asking how you want to map the 2 axial values
# to the 3 possible axes.
enum PrimaryAxes {QR, QS, RS}

var map: Dictionary = {} ## {Hex : Variant}
var axes: PrimaryAxes = PrimaryAxes.QR


## Abstract method that MUST be implemented by maps which extend HexMap. Populates the map with Hexes.
func _populate_map() -> void:
	push_error("UNIMPLEMENTED ERROR: HexMap._populate_map() MUST be implemented by inheriting classes.")


## Inserts a new Hex into the map along with a Variant object as its value. 
## If the Hex already exists, the Variant object replaces any existing one as its value.
func insert(hex: Hex, data: Variant = null, replaces_value: bool = true) -> void:
	if not replaces_value and hex in map and map[hex] == null:
		return # there's already a non-null key-value pair and replaces_value is false, so do nothing
	else:
		map[hex] = data


func get_hexes() -> Array:
	return map.keys()


func map_to_axes(coords: Vector2, to_axes: PrimaryAxes) -> Vector3:
	# the only difference between these 3 is where the inferred axis is (-q-r)
	match to_axes:
		PrimaryAxes.QR:
			return Vector3(coords.x, coords.y, -coords.x - coords.y)
		PrimaryAxes.QS:
			return Vector3(coords.x, -coords.x - coords.y, coords.y)
		PrimaryAxes.RS:
			return Vector3(-coords.x - coords.y, coords.x, coords.y)
		_:
			# this should never get reached, but if it does we default to QR
			return Vector3(coords.x, coords.y, -coords.x - coords.y)
