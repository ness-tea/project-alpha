extends Control

func _ready():
	$".".visible = false
	$Wallpaper/VBoxContainer/PanelContainer/Messages.visible = true
	$Wallpaper/VBoxContainer/PanelContainer/SingleMessages.visible = false


func _on_Message1_pressed():
	$Wallpaper/VBoxContainer/PanelContainer/Messages.visible = false
	$Wallpaper/VBoxContainer/PanelContainer/SingleMessages.visible = true
	$Wallpaper/VBoxContainer/PanelContainer/SingleMessages/Message1.visible = true
	$Wallpaper/VBoxContainer/PanelContainer/SingleMessages/Message2.visible = false

func _on_Message2_pressed():
	$Wallpaper/VBoxContainer/PanelContainer/Messages.visible = false
	$Wallpaper/VBoxContainer/PanelContainer/SingleMessages.visible = true
	$Wallpaper/VBoxContainer/PanelContainer/SingleMessages/Message1.visible = false
	$Wallpaper/VBoxContainer/PanelContainer/SingleMessages/Message2.visible = true

func _on_CloseButton_pressed():
	ClickSound.play()
	$".".visible = false


func _on_MessengerButton_pressed():
	ClickSound.play()
	$".".visible = !visible


func _on_Messenger_pressed():
	ClickSound.play()
	$".".visible = true


func _on_BackButton_pressed():
	$Wallpaper/VBoxContainer/PanelContainer/SingleMessages.visible = false
	$Wallpaper/VBoxContainer/PanelContainer/Messages.visible = true
