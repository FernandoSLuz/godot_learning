extends ItemContainer

@export var quantity: int = 5


func hit():
	spawn_items(quantity, $SpawnPositions)
