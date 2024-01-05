extends StaticBody2D
class_name ItemContainer

@onready var current_direction: Vector2 = Vector2.UP.rotated(rotation)
var opened: bool = false

signal open(pos, direction)

func spawn_items(quantity: int, spawn_positions: Node2D):
	if not opened:
		opened = true
		$LidSprite.hide()
		for i in range(quantity):
			var pos = spawn_positions.get_child(randi()%spawn_positions.get_child_count()).global_position
			open.emit(pos, current_direction)
