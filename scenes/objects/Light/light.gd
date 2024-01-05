extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$PointLight2D.enabled = false
	$PlayerTriggerZone.connect("on_player_entered", _on_player_trigger_zone_on_player_entered)
	$PlayerTriggerZone.connect("on_player_exited", _on_player_trigger_zone_on_player_exited)

func _on_player_trigger_zone_on_player_entered(_body):
	$PointLight2D.enabled = true

func _on_player_trigger_zone_on_player_exited(_body):
	$PointLight2D.enabled = false
