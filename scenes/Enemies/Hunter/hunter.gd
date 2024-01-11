extends CharacterBody2D

var active: bool = false
var speed: int = 200


func _ready():
	_on_navigation_timer_timeout()
	
func _physics_process(_delta):
	if(active):
		var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
		print(next_path_pos)
		var direction: Vector2 = (next_path_pos - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		look_at(Globals.player.global_position)
		_on_navigation_timer_timeout()


func _on_notice_area_body_entered(_body):
	active = true

func _on_notice_area_body_exited(_body):
	active = false


func _on_attack_area_body_entered(_body):
	pass # Replace with function body.


func _on_attack_area_body_exited(_body):
	pass # Replace with function body.


func _on_navigation_timer_timeout():
	if(active):
		$NavigationAgent2D.target_position = Globals.player.global_position
		$Timers/NavigationTimer.start(1)
	
