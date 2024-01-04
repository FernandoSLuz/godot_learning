extends CanvasLayer

var green: Color = Color("6bbfa3")
var blue: Color = Color.ROYAL_BLUE
var red: Color = Color(0.9,0,0,1)

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/Label
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect

func _ready():
	update_grenade_text()
	update_laser_text()

func update_laser_text():
	laser_label.text = str(Globals.laser_current_amount)
	var current_color = get_color_based_on_percentage(Globals.laser_current_amount, Globals.laser_max_amount)
	laser_label.modulate = current_color
	laser_icon.modulate = current_color
	
func update_grenade_text():
	grenade_label.text = str(Globals.grenade_current_amount)
	var current_color = get_color_based_on_percentage(Globals.grenade_current_amount, Globals.grenade_max_amount)
	grenade_label.modulate = current_color
	grenade_icon.modulate = current_color
	
func get_color_based_on_percentage(current_value: float, max_value: float) -> Color:
	var normalized_percentage = current_value/max_value
	if(normalized_percentage > 0.7):
		return green
	elif(normalized_percentage > 0.35):
		return blue
	else:
		return red
