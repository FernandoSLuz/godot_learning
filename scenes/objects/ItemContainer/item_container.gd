extends StaticBody2D
class_name ItemContainer

@onready var current_direction: Vector2 = Vector2.UP.rotated(rotation)
var opened: bool = false

signal open(pos, direction)
