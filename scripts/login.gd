extends Control


func _on_QuitButton_pressed():
	$ClickLoginSound.play()
	get_tree().quit()


func _on_LoginButton_pressed():
	$ClickLoginSound.play()
	get_tree().change_scene("res://scenes/desktop.tscn")


func _ready():
	if(GlobalVar.timelineDialogueNumber == null):
		GlobalVar.timelineDialogueNumber = 1
	if(GlobalVar.timelineDialogueNumber == 3):
		GlobalVar.timelineDialogueNumber = 4
		$UserImage.visible = false
		$FamilyImage.visible = true

