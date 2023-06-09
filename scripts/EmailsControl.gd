extends Control


func _ready():
	visible = false


func _on_CloseButton_pressed():
	ClickSound.play()
	visible = false


func _on_EmailsButton_pressed():
	ClickSound.play()
	visible = !self.visible


func _on_Email_pressed():
	ClickSound.play()
	visible = true
