extends RigidBody2D

const speed = 1500
@export_range(0, 1, 0.01) var grenade_bounce_normalized: float = 0.15
@export_range(-1, 100, 0.1) var grenade_linear_damp: float = 1.6

var exploding: bool = false
var explosion_radius: int = 400

func _ready():
	physics_material_override.bounce = grenade_bounce_normalized
	linear_damp = grenade_linear_damp
	
func _process(_delta):
	if exploding:
		calculate_targets_distance()

func calculate_targets_distance():
	var hitable_objects = get_tree().get_nodes_in_group('Container') + get_tree().get_nodes_in_group('Entities')
	for hitable_object in hitable_objects:
		var in_range:bool  = hitable_object.global_position.distance_to(global_position) < explosion_radius
		if in_range and "hit" in hitable_object:
			hitable_object.hit()

func explode():
	$AnimationPlayer.play("explosion")
	exploding = true
