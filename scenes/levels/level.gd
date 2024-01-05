extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser/laser.tscn")
var grenade_scene: PackedScene	= preload("res://scenes/projectiles/grenade/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/Items/item.tscn")

func _ready():
	for container in get_tree().get_nodes_in_group('Container'):
		container.connect("open", _on_container_opened)

func _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred('add_child', item)

func _on_player_laser_shot(respawn_position: Vector2, laser_direction: Vector2):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = respawn_position
	laser.rotation_degrees = rad_to_deg(laser_direction.angle())+90
	laser.direction = laser_direction
	$Projectiles.add_child(laser)
	$UI.update_laser_text()

func _on_player_grenade_shot(respawn_position: Vector2, grenade_direction: Vector2):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = respawn_position
	grenade.linear_velocity = grenade_direction * grenade.speed
	$Projectiles.add_child(grenade)
	$UI.update_grenade_text()


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player, "modulate:a", 0,1)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1), 1).set_trans(Tween.TRANS_SINE)


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player, "modulate:a", 1,1)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6,0.6), 1).set_trans(Tween.TRANS_SINE)


func _on_player_update_stats():
	$UI.update_laser_text()
	$UI.update_grenade_text()
