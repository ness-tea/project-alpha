extends Control

# Window Dragging functionality
var status = "none"
var offset = Vector2()
var mouse_pos = Vector2()

onready var title_node = get_node("Wallpaper/VBoxContainer/TitleBar/MessengerTitle")
onready var titlebar_size = title_node.get_size()

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


func _input(event):
	var event_pos = event.global_position
	
	if (event.is_action_pressed("ui_left_click")):
		var bar_pos = title_node.get_global_position()
		var target_rect = Rect2(bar_pos.x, bar_pos.y, titlebar_size.x, titlebar_size.y)
		
		if (target_rect.has_point(event_pos)):
			status = "clicked"
			offset = bar_pos - event_pos
		
		
	if (status == "clicked") and (event.is_class("InputEventMouseMotion")):
		status = "dragging"
		
	if (status == "dragging"):
		if (event.get_button_mask() != BUTTON_LEFT):
			status = "released"
		else:
			self.set_global_position(event_pos + offset)
				
			
