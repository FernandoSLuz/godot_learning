extends CanvasLayer

func change_scene(target) -> void:
	$AnimationPlayer.play("fade_to_black")
	await $AnimationPlayer.animation_finished
	if(typeof(target) == TYPE_STRING):
		get_tree().change_scene_to_file(target)
	else:
		get_tree().change_scene_to_packed(target)
	$AnimationPlayer.play("reveal")
