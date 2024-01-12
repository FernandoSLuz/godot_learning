extends CharacterBody2D

var player_near: bool = false
var max_speed: int = 600
var speed: int = 0
var speed_multiplier: int = 1
var health: int = 20
var vulnerable: bool = true
var exploding: bool = false
var explosion_radius: int = 400

func _process(delta):
	if player_near:
		if speed_multiplier > 0:
			Globals.look_at_smoothly($'.', Globals.player, delta)
		var direction = (Globals.player.position - position).normalized()
		velocity = direction * speed * speed_multiplier
		var collision = move_and_collide(velocity * delta)
		if collision:
			hit(100)
	if exploding:
		calculate_targets_distance()

func calculate_targets_distance():
	var hitable_objects = get_tree().get_nodes_in_group('Container') + get_tree().get_nodes_in_group('Entities')
	for hitable_object in hitable_objects:
		var in_range:bool  = hitable_object.global_position.distance_to(global_position) < explosion_radius
		if in_range and "hit" in hitable_object:
			hitable_object.hit()

func hit(value:int = 10):
	if vulnerable:
		$Audios/Hit.play()
		$Sprite2D.material.set_shader_parameter("progress", 1)
		health -= value
		if(health > 0):
			vulnerable = false
			$HitTimer.start(0.5)
		else:
			speed_multiplier = 0
			exploding = true
			$AnimationPlayer.play('explosion')

func _on_notice_area_2d_body_entered(_body):
	player_near = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 6).set_ease(Tween.EASE_OUT)

func _on_hit_timer_timeout():
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
