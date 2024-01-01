extends RigidBody2D

const speed = 1500
@export_range(0, 1, 0.01) var grenade_bounce_normalized: float = 0.15
@export_range(-1, 100, 0.1) var grenade_linear_damp: float = 1.6


func _ready():
	physics_material_override.bounce = grenade_bounce_normalized
	linear_damp = grenade_linear_damp

func explode():
	$AnimationPlayer.play("explosion")
