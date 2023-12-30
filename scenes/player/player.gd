extends CharacterBody2D

signal on_laser_shot(position, direction)
signal on_grenade_shot(position, direction)

var can_laser: bool = true
var can_grenade: bool = true

func _process(_delta):
	#input
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * 500
	move_and_slide()
	
	#rotate
	look_at(get_global_mouse_position())
	
	#lase input
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_just_pressed("primary_action") and can_laser:
		var selected_laser_respawn = randomize_respawn($WeaponStartPositions)
		on_laser_shot.emit(selected_laser_respawn.global_position, player_direction)
		can_laser = false
		$LaserTimer.start(0.5)
		
	#grenade input
	if Input.is_action_just_pressed("secondary_action") and can_grenade:
		var selected_grenade_respawn = randomize_respawn($WeaponStartPositions)
		on_grenade_shot.emit(selected_grenade_respawn.global_position, player_direction)
		can_grenade = false
		$GrenadeTimer.start(2.0)

func randomize_respawn(node: Node2D) -> Marker2D:
	var respawns = node.get_children()
	var respawn = respawns[randf_range(0, respawns.size())]
	return respawn

func _on_laser_timer_timeout():
	can_laser = true

func _on_grenade_timer_timeout():
	can_grenade = true
