extends Area2D

signal on_player_entered(body)
signal on_player_exited(body)	

func _on_body_entered(body):
	on_player_entered.emit(body)

func _on_body_exited(body):
	on_player_exited.emit(body)
