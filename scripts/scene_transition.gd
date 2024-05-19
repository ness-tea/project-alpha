extends CanvasLayer


func change_scene(target: String) -> void:
	#if get_tree().current_scene.name == "IntroductionScene":
		#$AnimationPlayer.play("fade_to_black_intro")
		#yield($AnimationPlayer, "animation_finished")
		#get_tree().change_scene(target)
		#$AnimationPlayer.play("fade_to_normal_intro")
	#else:
	$AnimationPlayer.play("fade_to_black")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(target)
	$AnimationPlayer.play("fade_to_normal")
