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
		
	if(GlobalVar.gameEndCondition == true):
		_end_Game()
	else:
		$StartPanelContainer/LoginButton.visible = true
		$StartPanelContainer/LockedButton.visible = false
		$EndGameCredits.visible = false
		$Name/NameLabel.text = "Sam"
		
	if(GlobalVar.timelineDialogueNumber == 3):
		GlobalVar.timelineDialogueNumber = 4
		$UserImage.visible = false
		$AlImage.visible = true
		$Name/NameLabel.text = "Alpha"

func _end_Game():
	$UserImage.visible = false
	$AlImage.visible = false
	$LockedImage.visible = true
	$StartPanelContainer/LoginButton.visible = false
	$StartPanelContainer/LockedButton.visible = true
	$EndGameCredits.visible = true
	$Name/NameLabel.text = "Locked"
