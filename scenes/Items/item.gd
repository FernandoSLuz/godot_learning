extends Area2D

var rotation_speed: int = 4
var available_options = [
	{'name': 'laser', 'weight': 4},
	{'name': 'grenade', 'weight': 1},
	{'name': 'health', 'weight': 1}
]
@onready var type = randomize_based_on_weight()

var direction: Vector2
var distance: int = randi_range(150, 200)

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
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1,1), 0.5).from(Vector2(0,0))

func _process(delta):
	rotation += rotation_speed * delta

func _on_body_entered(_body):
	if type == 'laser' and Globals.laser_current_amount < Globals.laser_max_amount:
		Globals.laser_current_amount = min(Globals.laser_current_amount + 5, Globals.laser_max_amount)
		queue_free()
	elif type == 'grenade' and Globals.grenade_current_amount < Globals.grenade_max_amount:
		Globals.grenade_current_amount = min(Globals.grenade_current_amount + 2, Globals.grenade_max_amount)
		queue_free()
	elif type == 'health' and Globals.health_current_amount < Globals.health_max_amount:
		Globals.health_current_amount = min(Globals.health_current_amount + 10, Globals.health_max_amount)
		queue_free()

