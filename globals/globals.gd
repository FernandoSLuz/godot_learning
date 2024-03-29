extends Node

signal stat_change

var player_hit_sound: AudioStreamPlayer2D
var player: CharacterBody2D
var laser_max_amount: float = 20
var laser_current_amount: float = 10:
	get:
		return laser_current_amount
	set(value):
		laser_current_amount = value
		stat_change.emit()

var grenade_max_amount: float = 5
var grenade_current_amount: float = 3:
	get:
		return grenade_current_amount
	set(value):
		grenade_current_amount = value
		stat_change.emit()

var damage_cooldown:bool = false
var health_max_amount: float = 100
var health_current_amount: float = 60:
	get:
		return health_current_amount
	set(value):
		if value > health_current_amount:
			health_current_amount = min(value, 100)
		elif not damage_cooldown:
			health_current_amount = value
			damage_cooldown = true
			player_invulnerable_time()
			player_hit_sound.global_position = player.global_position
			player_hit_sound.play()
		stat_change.emit()

func _ready():
	player_hit_sound = AudioStreamPlayer2D.new()
	player_hit_sound.stream = load("res://audio/solid_impact.ogg")
	add_child(player_hit_sound)

func player_invulnerable_time():
	await get_tree().create_timer(0.5).timeout
	damage_cooldown = false

func look_at_smoothly(object, target, delta):
	var target_dir: Vector2 = (target.global_position - object.global_position).normalized()
	var look_speed: float = 4  # Determines how fast the enemy looks at the player
	var target_rotation: float # Target rotation in radians
	target_rotation = atan2(target_dir.y, target_dir.x)
	# Interpolate the current rotation toward the target rotation
	object.rotation = lerp_angle(object.rotation, target_rotation, look_speed * delta)
