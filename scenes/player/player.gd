extends CharacterBody2D

signal on_laser_shot()
signal on_grenade_shot()

var can_laser: bool = true
var can_grenade: bool = true

func _process(_delta):
	#input
	var direction = Input.get_vector("left","right","up","down")
	#position += direction * 500 * delta
	velocity = direction * 500
	move_and_slide()
	
	#lase input
	if Input.is_action_just_pressed("primary_action") and can_laser:
		on_laser_shot.emit(self)
		can_laser = false
		$laser_timer.start(0.5)
		
	#grenade input
	if Input.is_action_just_pressed("secondary_action") and can_grenade:
		on_grenade_shot.emit(self)
		can_grenade = false
		$grenade_timer.start(2.0)

func _on_laser_timer_timeout():
	can_laser = true

func _on_grenade_timer_timeout():
	can_grenade = true
