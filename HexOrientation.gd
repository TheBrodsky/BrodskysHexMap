extends RefCounted
class_name HexOrientation


## HexOrientation is a static class that stores values for operations that
## differ between the two hexagon layouts: flat and pointy.


# conversion matrices to convert hex coords to screen coords
const POINTY_CONVERSION_MAT: Transform2D = Transform2D(Vector2(sqrt(3), sqrt(3) / 2), Vector2(0, 3.0/2), Vector2.ZERO)
const FLAT_CONVERSION_MAT: Transform2D = Transform2D(Vector2(3.0/2, 0), Vector2(sqrt(3) / 2, sqrt(3)), Vector2.ZERO)

# angle offset of the first (arbitrary) point on a hex depending on orientation
const POINTY_START_ANGLE: float = deg_to_rad(30)
const FLAT_START_ANGLE: float = 0


# the int values of these Enums correspond to the index of the equivalent neighbor vector
enum PointyNeighbor {EAST, NORTHEAST, NORTHWEST, WEST, SOUTHWEST, SOUTHEAST}
enum FlatNeighbor {SOUTHEAST, NORTHEAST, NORTH, NORTHWEST, SOUTHWEST, SOUTH}
const NEIGHBOR_VECS: Array[Vector3i] = [
	Vector3i(1, 0, -1), Vector3i(1, -1, 0), Vector3i(0, -1, 1),
	Vector3i(-1, 0, 1), Vector3i(-1, 1, 0), Vector3i(0, 1, -1)
]

enum PointyDiagonal {NORTHEAST, NORTH, NORTHWEST, SOUTHWEST, SOUTH, SOUTHEAST}
enum FlatDiagonal {EAST, NORTHEAST, NORTHWEST, WEST, SOUTHWEST, SOUTHEAST}
const DIAGONAL_VECS: Array[Vector3i] = [
	Vector3i(2, -1, -1), Vector3i(1, -2, 1), Vector3i(-1, -1, 2),
	Vector3i(-2, 1, 1), Vector3i(-1, 2, -1), Vector3i(1, 1, -2)
]
