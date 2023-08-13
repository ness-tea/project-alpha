extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


func _on_StartButton_pressed():
	ClickSound.play()
	visible = !visible
