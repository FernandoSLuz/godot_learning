extends PathFollow2D

var player_near: bool = false

@onready var ray1: Line2D = $Turret/Canon1/Ray1
@onready var ray2: Line2D = $Turret/Canon2/Ray2

@onready var fire1: Sprite2D = $Turret/Canon1/Fire1
@onready var fire2: Sprite2D = $Turret/Canon2/Fire2

func fire():
	Globals.health_current_amount -= 20
	fire1.modulate.a = 1
	fire2.modulate.a = 1
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(fire1, "modulate:a", 0, randf_range(0.1,0.5))
	tween.tween_property(fire2, "modulate:a", 0, randf_range(0.1,0.5))

func _ready():
	ray2.add_point($Turret/Canon2.target_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_ratio += 0.025 * delta
	if player_near:
		$Turret.look_at(Globals.player.position)
	
func _on_notice_area_body_entered(_body):
	$AnimationPlayer.stop()
	$AnimationPlayer.play("laser_load")
	player_near = true

func _on_notice_area_body_exited(_body):
	$AnimationPlayer.pause()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(ray1, "width", 0, randf_range(0.1,0.5))
	tween.tween_property(ray2, "width", 0, randf_range(0.1,0.5))
	await tween.finished
	$AnimationPlayer.stop()
	player_near = false
