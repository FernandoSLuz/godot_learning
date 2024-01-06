extends Node

signal stat_change

var laser_max_amount: float = 20
var laser_current_amount: float = 10:
	get:
		return laser_current_amount
	set(value):
		laser_current_amount = value
		stat_change.emit()

var grenade_max_amount: float = 5
var grenade_current_amount: float = 3:
	get:
		return grenade_current_amount
	set(value):
		grenade_current_amount = value
		stat_change.emit()

var damage_cooldown:bool = false
var health_max_amount: float = 100
var health_current_amount: float = 60:
	get:
		return health_current_amount
	set(value):
		if value > health_current_amount:
			health_current_amount = min(value, 100)
		elif not damage_cooldown:
			health_current_amount = value
			damage_cooldown = true
			player_invulnerable_time()
		stat_change.emit()


func player_invulnerable_time():
	await get_tree().create_timer(0.5).timeout
	damage_cooldown = false

var player: CharacterBody2D
