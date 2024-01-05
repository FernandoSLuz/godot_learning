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

var health_max_amount: float = 100
var health_current_amount: float = 60:
	get:
		return health_current_amount
	set(value):
		health_current_amount = value
		stat_change.emit()
