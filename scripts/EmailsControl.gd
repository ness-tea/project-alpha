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

# Window Dragging functionality
enum State {NONE, WINDOW_CLICKED, TITLEBAR_CLICKED, DRAGGING, RELEASED}

var status = State.NONE
var offset = Vector2()
var mouse_pos = Vector2()

onready var titlebar_node = get_node("TitleBar/WindowTitle")
onready var titlebar_size = titlebar_node.get_size()
onready var window_node = get_node("Wallpaper")
onready var window_size = window_node.get_size()

func _input(event):
	# Get position of input event in global space
	var event_pos = event.global_position
	
	# Check if input event is a mouse left click
	if (event.is_action_pressed("ui_left_click")):
		
		# Get title bar position in global space
		var titlebar_pos = titlebar_node.get_global_position()
		
		# Calculate title bar rect based on title bar global position and title bar size
		var titlebar_rect = Rect2(titlebar_pos.x, titlebar_pos.y, titlebar_size.x, titlebar_size.y)
		var window_rect = Rect2(titlebar_pos.x, titlebar_pos.y, window_size.x, window_size.y)

		# Check if input event position is within window rect
		if (window_rect.has_point(event_pos)):
			status = State.WINDOW_CLICKED
			
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
			
