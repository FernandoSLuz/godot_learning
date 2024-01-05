extends ItemContainer

@export var quantity: int = 1

func hit():
	spawn_items(quantity, $SpawnPositions)
