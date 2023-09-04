extends Control

var projectAlClick = 0
var projectAlClickTime = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioManager/BackgroundMusic.play()

func _process(delta):
	if projectAlClick == 1:
		projectAlClickTime += delta
	if (projectAlClickTime > 2):
		projectAlClick = 0
		projectAlClickTime = 0


func _on_Logout_pressed():
	ClickSound.play()
	$AudioManager/ShutDown.play()
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().quit()


func _on_ProjectAlProgram_pressed():
	ClickSound.play()
	projectAlClick += 1
	if (projectAlClick == 2 && projectAlClickTime <= 2):
		$ProjectAlProgram.visible = false
		get_tree().change_scene("res://scenes/al.tscn")

#This button is used for testing purposes only. It is used to skip to the final dialogue with Al
func _on_Button_pressed():
	GlobalVar.timelineDialogueNumber = 3
