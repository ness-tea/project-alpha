extends Control


func _on_QuitButton_pressed():
	$ClickLoginSound.play()
	get_tree().quit()


func _on_LoginButton_pressed():
	$ClickLoginSound.play()
	get_tree().change_scene("res://scenes/desktop.tscn")
