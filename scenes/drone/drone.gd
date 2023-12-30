extends CharacterBody2D

var drone_speed: int = 500
var drone_image: Sprite2D
var drone_size: Vector2

func _ready():
	drone_image = $Sprite2D
	drone_size = drone_image.get_rect().size
	respawn_drone()

func _process(delta):
	move_drone(delta)
	
func move_drone(delta):
	var direction = Vector2.RIGHT
	
	velocity = direction * drone_speed
	
	move_and_slide()
	
	if position.x > get_viewport_rect().size.x+(drone_size.x/2):
		respawn_drone()

func respawn_drone():
	var viewport_rect = get_viewport_rect()
	var random_y = randf_range(0+(drone_size.y/2), viewport_rect.size.y-(drone_size.y/2))
	position = Vector2(0-(drone_size.x/2), random_y)
