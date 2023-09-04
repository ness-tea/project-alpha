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
	GlobalVar.top_window = GlobalVar.Window.NONE
	print("Current top window - NONE")
	$".".visible = false


func _on_MessengerButton_pressed():
	ClickSound.play()
	$".".visible = !visible
	
	if (visible):
		GlobalVar.top_window = GlobalVar.Window.MESSENGER
		GlobalVar.top_window_pos = window_node.get_global_position()
		GlobalVar.top_window_size = window_size
		print("Current top window - Messenger")
	else:
		GlobalVar.top_window = GlobalVar.Window.NONE
		print("Current top window - NONE")


func _on_Messenger_pressed():
	ClickSound.play()
	$".".visible = true


func _on_BackButton_pressed():
	$Wallpaper/VBoxContainer/PanelContainer/SingleMessages.visible = false
	$Wallpaper/VBoxContainer/PanelContainer/Messages.visible = true

# Window Dragging functionality
enum State {NONE, WINDOW_CLICKED, TITLEBAR_CLICKED, DRAGGING, RELEASED}

var status = State.NONE
var offset = Vector2()
var mouse_pos = Vector2()

onready var titlebar_node = get_node("Wallpaper/VBoxContainer/TitleBar/MessengerTitle")
onready var titlebar_size = titlebar_node.get_size()
onready var window_node = get_node("Wallpaper")
onready var window_size = window_node.get_size()
onready var window_pos = window_node.get_global_position()

func _is_underlapping_top_window(event_pos):
	if (GlobalVar.top_window != GlobalVar.Window.MESSENGER and self.visible):	
		if ((GlobalVar.top_window_pos != null and GlobalVar.top_window_size != null) and
			(event_pos.x > GlobalVar.top_window_pos.x and
			event_pos.x < (GlobalVar.top_window_pos.x + GlobalVar.top_window_size.x) and
			event_pos.y > GlobalVar.top_window_pos.y and
			event_pos.y < (GlobalVar.top_window_pos.y + GlobalVar.top_window_size.y))):
			
			return true
				
	return false

func _input(event):
	# Get position of input event in global space
	var event_pos = event.global_position
	
	# Check if input event is a mouse left click
	if (event.is_action_pressed("ui_left_click")):
		
		if (GlobalVar.top_window != GlobalVar.Window.MESSENGER and !self.visible):
			return
		else:
			# Get title bar position in global space
			var titlebar_pos = titlebar_node.get_global_position()
			
			# Calculate title bar rect based on title bar global position and title bar size
			var titlebar_rect = Rect2(titlebar_pos.x, titlebar_pos.y, titlebar_size.x, titlebar_size.y)
			var window_rect = Rect2(titlebar_pos.x, titlebar_pos.y, window_size.x, window_size.y)

			# Check if input event position is within window rect AND
			# that it's not within an underlapping region of the top-most window		
			if (window_rect.has_point(event_pos) and !_is_underlapping_top_window(event_pos)):
				status = State.WINDOW_CLICKED
				
				# Set this window to current top window
				GlobalVar.top_window = GlobalVar.Window.MESSENGER
				GlobalVar.top_window_pos = window_node.get_global_position()
				GlobalVar.top_window_size = window_size
				
				# Check if event position is within title bar rect
				if (titlebar_rect.has_point(event_pos)):
					status = State.TITLEBAR_CLICKED
					
					# Calculate the offset - to be used in repositioning window during dragging
					offset = titlebar_pos - event_pos

				# If any part of the window is clicked, put it into focus
				raise()	
		
	# Only set state to DRAGGING if title bar is clicked when mouse is in motion
	if (status == State.TITLEBAR_CLICKED) and (event.is_class("InputEventMouseMotion")):
		status = State.DRAGGING
		
	# Handling for changing a dragging window's position
	if (status == State.DRAGGING):
		if (event.get_button_mask() != BUTTON_LEFT):
			status = State.RELEASED
		else:
			self.set_global_position(event_pos + offset)
