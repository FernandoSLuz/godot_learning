extends Area2D

var rotation_speed: int = 4
var available_options = [
	{'name': 'laser', 'weight': 4},
	{'name': 'grenade', 'weight': 1},
	{'name': 'health', 'weight': 1}
]
@onready var type = randomize_based_on_weight()

func randomize_based_on_weight() -> String:
	var temp_options = []
	for item in available_options:
		for repetition in item['weight']:
			temp_options.append(item['name'])
	return str(temp_options[randi()%len(temp_options)])

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color.CORNFLOWER_BLUE
	elif type == 'grenade':
		$Sprite2D.modulate = Color.INDIAN_RED
	elif type == 'health':
		$Sprite2D.modulate = Color.LIME_GREEN

func _process(delta):
	rotation += rotation_speed * delta

func _on_body_entered(body):
	if type == 'laser' and Globals.laser_current_amount < 20:
		body.add_item(type)
		queue_free()
	elif type == 'grenade' and Globals.grenade_current_amount < 5:
		body.add_item(type)
		queue_free()
	elif type == 'health':
		body.add_item(type)
		queue_free()

