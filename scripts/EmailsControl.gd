extends Control

# Window Dragging functionality
var status = "none"
var offset = Vector2()
var mouse_pos = Vector2()

onready var title_node = get_node("TitleBar/WindowTitle")
onready var titlebar_size = title_node.get_size()

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

func _input(event):
	var event_pos = event.global_position
	
	if (event.is_action_pressed("ui_left_click")):
		var bar_pos = title_node.get_global_position()
		var target_rect = Rect2(bar_pos.x, bar_pos.y, titlebar_size.x, titlebar_size.y)
		
		if (target_rect.has_point(event_pos)):
			status = "clicked"
			offset = bar_pos - event_pos
			raise()
		
	if (status == "clicked") and (event.is_class("InputEventMouseMotion")):
		status = "dragging"
		
	if (status == "dragging"):
		if (event.get_button_mask() != BUTTON_LEFT):
			status = "released"
		else:
			self.set_global_position(event_pos + offset)
