extends Node


var laser_max_amount: float = 20
var laser_current_amount: float
var grenade_max_amount: float = 5
var grenade_current_amount: float

func _init():
	laser_current_amount = laser_max_amount
	grenade_current_amount = grenade_max_amount

