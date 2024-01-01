extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	$SelfDestructTimer.stop()
	if body.has_method("hit"): #you can also use 'if "hit" in body:'
		body.hit()
	queue_free()


func _on_timer_timeout():
	print('stoped')
	queue_free()
