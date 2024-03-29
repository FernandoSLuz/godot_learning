extends CharacterBody2D

var active: bool = false
var speed: int = 300
var vulnerable: bool = true
var player_near: bool = false
var health:int = 20

func hit():
	if vulnerable:
		$AudioStreamPlayer2D.play()
		health -= 10
		$Particles/HitParticles.emitting = true
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
		if health > 0:
			vulnerable = false
			$Node/HitTimer.start(0.25)
		else:
			await get_tree().create_timer(0.5).timeout
			queue_free()


func _process(delta):
	var player_dir: Vector2 = (Globals.player.position - position).normalized()
	velocity = player_dir * speed
	if active:
		move_and_slide()
		Globals.look_at_smoothly($".", Globals.player, delta)

func _on_attack_area_2d_body_entered(_body):
	player_near = true
	$AnimatedSprite2D.play("attack")

func _on_attack_area_2d_body_exited(_body):
	player_near = false
	$AnimatedSprite2D.play("walk")

func _on_notice_area_2d_body_entered(_body):
	active = true
	$AnimatedSprite2D.play("walk")

func _on_notice_area_2d_body_exited(_body):
	active = false
	$AnimatedSprite2D.stop()

func _on_animated_sprite_2d_animation_finished():
	if player_near:
		Globals.health_current_amount -= 10
		$Node/AttackTimer.start(1)

func _on_attack_timer_timeout():
	$AnimatedSprite2D.play("attack")

func _on_hit_timer_timeout():
	vulnerable = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
