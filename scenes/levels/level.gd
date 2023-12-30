extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser/laser.tscn")
var grenade_scene: PackedScene	= preload("res://scenes/projectiles/grenade/grenade.tscn")


func _on_player_entered_gate(body):
	if(body.name == 'Player'):
		print("body has entered: ", body)

func _on_player_exited_gate(body):
	if(body.name == 'Player'):
		print("body has exited: ", body)

func _on_player_laser_shot(_character: CharacterBody2D, respawn: Vector2):
	var laser = laser_scene.instantiate()
	$Projectiles.add_child(laser)
	laser.position = respawn
	print("laser shot: ", respawn)

func _on_player_grenade_shot(_character: CharacterBody2D, respawn: Vector2):
	var grenade = grenade_scene.instantiate()
	$Projectiles.add_child(grenade)
	grenade.position = respawn
	print("grenade shot: ", _character)
