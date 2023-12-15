extends Control


func _on_QuitButton_pressed():
	$ClickLoginSound.play()
	get_tree().quit()


func _on_LoginButton_pressed():
	$ClickLoginSound.play()
	SceneTransition.change_scene("res://scenes/desktop.tscn")


func _ready():
	if(GlobalVar.timelineDialogueNumber == null):
		GlobalVar.timelineDialogueNumber = 1
	if(GlobalVar.timelineDialogueNumber == 3):
		GlobalVar.timelineDialogueNumber = 4
		$UserImage.visible = false
		$FamilyImage.visible = true
	if(GlobalVar.gameEndCondition == true):
		_end_Game()
	else:
		$StartPanelContainer/LoginButton.visible = true
		$StartPanelContainer/LockedButton.visible = false
		$EndGameCredits.visible = false
	

func _end_Game():
	$UserImage.visible = false
	$FamilyImage.visible = false
	$LockedImage.visible = true
	$StartPanelContainer/LoginButton.visible = false
	$StartPanelContainer/LockedButton.visible = true
	$EndGameCredits.visible = true
