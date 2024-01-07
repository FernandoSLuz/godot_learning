extends CharacterBody2D

signal laser(pos, direction)

var can_laser: bool = true
var health: int = 30

var look_speed: float = 4  # Determines how fast the enemy looks at the player
var target_rotation: float # Target rotation in radians

func _ready():
	$Sprite2D.material.set_shader_parameter("progress", 0)

func _process(delta):
	if Globals.player and position.distance_to(Globals.player.position) < 1000:
		look_mechanics(delta)
		shoot_mechanics()

func look_mechanics(delta):
	var player_dir: Vector2 = (Globals.player.position - position).normalized()
	target_rotation = atan2(player_dir.y, player_dir.x)
	# Interpolate the current rotation toward the target rotation
	rotation = lerp_angle(rotation, target_rotation, look_speed * delta)

func shoot_mechanics():
	if can_laser:
		var pos: Vector2 = switch_respawn($LaserSpawnPositions).global_position
		var direction: Vector2 = Vector2(cos(rotation), sin(rotation)).normalized()
		laser.emit(pos, direction)
		can_laser = false
		$Timers/LaserCooldown.start(1.0)

var right_gun_use:bool = false
func switch_respawn(node: Node2D) -> Marker2D:
	var respawn = node.get_child(right_gun_use)
	right_gun_use = not right_gun_use
	return respawn

func hit():
	if not damage_cooldown:
		damage_cooldown = true
		health -= 10
		if health <= 0:
			queue_free()
		$Timers/DamageCooldown.start(0.5)
		$Sprite2D.material.set_shader_parameter("progress", 1)

var damage_cooldown:bool = false
func _on_damage_cooldown_timeout():
	$Sprite2D.material.set_shader_parameter("progress", 0)
	damage_cooldown = false
	
func _on_laser_cooldown_timeout():
	can_laser = true
