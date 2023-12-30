extends Node2D

func _on_player_entered_gate(body):
	if(body.name == 'Player'):
		print("body has entered: ", body)

func _on_player_exited_gate(body):
	if(body.name == 'Player'):
		print("body has exited: ", body)

func _on_player_laser_shot(character: CharacterBody2D):
	print("laser shot: ", character)

func _on_player_grenade_shot(character: CharacterBody2D):
	print("grenade shot: ", character)
