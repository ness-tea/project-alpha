extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


func _on_VideoCallButton_pressed():
	ClickSound.play()
	visible = !self.visible


func _on_Close_pressed():
	ClickSound.play()
	visible = false


func _on_Accept_pressed():
	ClickSound.play()
	visible = true
	get_node("EmptyRoom").visible = false
	if(GlobalVar.timelineDialogueNumber == 1):
		# Start Martin first call dialogue
		var martinDialog = Dialogic.start("FirstMeetingWithMartin")
		dialogic_additional_functions(martinDialog)
		
	elif(GlobalVar.timelineDialogueNumber == 2):
		# Start Martin second call dialogue
		var martinDialog = Dialogic.start("SecondMeetingWithMartin")
		dialogic_additional_functions(martinDialog)
		
	elif(GlobalVar.timelineDialogueNumber == 3):
		# Start Martin third call dialogue
		var martinDialog = Dialogic.start("ThirdMeetingWithMartin")
		dialogic_additional_functions(martinDialog)
	
	elif(GlobalVar.timelineDialogueNumber == 4):
		# Start Martin third call dialogue
		var martinDialog = Dialogic.start("FourthMeetingWithMartin")
		dialogic_additional_functions(martinDialog)


func _on_VideoCall_pressed():
	ClickSound.play()
	visible = true

func dialogic_additional_functions(martinDialog):
	add_child(martinDialog)
	if(GlobalVar.timelineDialogueNumber == 3):
		martinDialog.connect("timeline_end", self, "blackout_screen")
	else:
		martinDialog.connect("timeline_end", self, "after_dialog")


func after_dialog(_param):
	get_node("EmptyRoom").visible = true
	$"../ProjectAlProgram".makeIconVisible()


func switch_to_projectAl(_param):
	get_tree().change_scene("res://scenes/al.tscn")
	

func blackout_screen(_param):
	for i in 3:
		$"../BlackScreen".visible = false
		yield(get_tree().create_timer(0.3), "timeout")
		$"../BlackScreen".visible = true
		yield(get_tree().create_timer(0.3), "timeout")
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://scenes/login.tscn")

# Window Dragging functionality
enum State {NONE, WINDOW_CLICKED, TITLEBAR_CLICKED, DRAGGING, RELEASED}

var status = State.NONE
var offset = Vector2()
var mouse_pos = Vector2()

onready var titlebar_node = get_node("TitleBar/WindowTitle")
onready var titlebar_size = titlebar_node.get_size()
onready var window_node = get_node("Background")
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
