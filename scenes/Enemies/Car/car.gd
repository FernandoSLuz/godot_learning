extends PathFollow2D

var player_near: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#progress_ratio += 0.00 * delta
	if player_near:
		#Globals.look_at_smoothly($Turret, Globals.player, delta)
		$Turret.look_at(Globals.player.position)


func _on_notice_area_body_entered(body):
	player_near = true

func _on_notice_area_body_exited(body):
	player_near = false
