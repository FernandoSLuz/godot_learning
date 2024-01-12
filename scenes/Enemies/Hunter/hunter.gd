extends CharacterBody2D

var active: bool = false
var attack_area: bool = true
var speed: int = 200

var health: int = 40
var vulnerable: bool = true

func _ready():
	if(Globals.player):
		$NavigationAgent2D.path_desired_distance = 4.0
		$NavigationAgent2D.target_desired_distance = 4.0
		$NavigationAgent2D.target_position = Globals.player.global_position
	
func _physics_process(_delta):
	if(active):
		var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_pos - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		var look_angle = direction.angle()
		rotation = look_angle + PI /2


func _on_notice_area_body_entered(_body):
	active = true
	$AnimationPlayer.play("walk")

func _on_notice_area_body_exited(_body):
	active = false
	$Timers/NavigationTimer.stop()


func _on_attack_area_body_entered(_body):
	attack_area = true
	$AnimationPlayer.play("attack")


func _on_attack_area_body_exited(_body):
	attack_area = false
	$AnimationPlayer.play("walk")
	
func attack():
	if(attack_area):
		Globals.health_current_amount -= 20
		
func hit():
	if vulnerable:
		vulnerable = false
		health -= 10
		if(health <= 0):
			queue_free()
		else:
			$Timers/HitTimer.start(0.5)

func _on_hit_timer_timeout():
	vulnerable = true

func _on_navigation_timer_timeout():
	if(active):
		$NavigationAgent2D.target_position = Globals.player.global_position
	



