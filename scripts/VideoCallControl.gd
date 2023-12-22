extends Control

var status = GlobalVar.State.NONE
var offset = Vector2()
var mouse_pos = Vector2()

onready var titlebar_node = get_node("TitleBar/WindowTitle")
onready var titlebar_size = titlebar_node.get_size()
onready var window_node = get_node("Background")
onready var window_size = window_node.get_size()

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


func _on_VideoCallButton_pressed():
	ClickSound.play()
	if (GlobalVar.top_window != GlobalVar.Window.NONE and GlobalVar.top_window != GlobalVar.Window.VIDEO_CALL):
		visible = true
		_set_global_top_window()
	else:
		visible = !self.visible

		if (visible):
			_set_global_top_window()
		else:
			GlobalVar.top_window = GlobalVar.Window.NONE


func _on_Close_pressed():
	ClickSound.play()
	GlobalVar.top_window = GlobalVar.Window.NONE
	visible = false

#on accpetance of call, the user will go into a specific dialogic timeline
func _on_Accept_pressed():
	ClickSound.play()
	visible = true
	get_node("EmptyRoom").visible = false
	
	raise()
	
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
	yield(get_tree().create_timer(2), "timeout")
	$"../LoadingBar".visible = true
	$"../LoadingBar/AnimationPlayer".play("loading_bar")
	yield($"../LoadingBar/AnimationPlayer", "animation_finished")
	$"../LoadingBar".visible = false
	$"../ProjectAlProgram".makeIconVisible()


func switch_to_projectAl(_param):
	get_tree().change_scene("res://scenes/al.tscn")

#Screen blacks out for "glitch" effect
func blackout_screen(_param):
	$"../AudioManager/CreepyLaugh".play()
	for i in 2:
		$"../CanvasLayer".visible = false
		yield(get_tree().create_timer(0.3), "timeout")
		$"../CanvasLayer".visible = true
		yield(get_tree().create_timer(0.3), "timeout")
	$"../CanvasLayer".visible = false
	yield(get_tree().create_timer(1.1), "timeout")
	$"../CanvasLayer".visible = true
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://scenes/login.tscn")

func _is_underlapping_top_window(event_pos):
	if (GlobalVar.top_window != GlobalVar.Window.VIDEO_CALL):	
		if ((GlobalVar.top_window_pos != null and GlobalVar.top_window_size != null) and
			(event_pos.x > GlobalVar.top_window_pos.x and
			event_pos.x < (GlobalVar.top_window_pos.x + GlobalVar.top_window_size.x) and
			event_pos.y > GlobalVar.top_window_pos.y and
			event_pos.y < (GlobalVar.top_window_pos.y + GlobalVar.top_window_size.y))):
			return true
	return false

func _input(event):
	if (event.is_class("InputEventMouse")):
		
		# Get position of input event in global space
		var event_pos = event.global_position
		
		# Check if input event is a mouse left click
		if (event.is_action_pressed("ui_left_click")):
			if (self.visible):
				# Get title bar position in global space
				var titlebar_pos = titlebar_node.get_global_position()
				
				# Calculate title bar rect based on title bar global position and title bar size
				var titlebar_rect = Rect2(titlebar_pos.x, titlebar_pos.y, titlebar_size.x, titlebar_size.y)
				var window_rect = Rect2(titlebar_pos.x, titlebar_pos.y, window_size.x, window_size.y)

				# Check if input event position is within window rect AND
				# that it's not within an underlapping region of the top-most window		
				if (window_rect.has_point(event_pos) and !_is_underlapping_top_window(event_pos)):
					status = GlobalVar.State.WINDOW_CLICKED
					
					# Set this window to current top window
					_set_global_top_window()
					
					# Check if event position is within title bar rect
					if (titlebar_rect.has_point(event_pos)):
						status = GlobalVar.State.TITLEBAR_CLICKED
						
						# Calculate the offset - to be used in repositioning window during dragging
						offset = titlebar_pos - event_pos
				
		# Only set state to DRAGGING if title bar is clicked when mouse is in motion
		if (status == GlobalVar.State.TITLEBAR_CLICKED) and (event.is_class("InputEventMouseMotion")):
			status = GlobalVar.State.DRAGGING
			
		# Handling for changing a dragging window's position
		""" REMOVED DRAGGING OF WINDOW DUE TO INABILITY TO CHANGE DIALOGIC PORTRAIT POSITION
		
		if (status == GlobalVar.State.DRAGGING):
			if (event.get_button_mask() != BUTTON_LEFT):
				status = GlobalVar.State.RELEASED
			else:
				self.set_global_position(event_pos + offset)
		"""


func _set_global_top_window():
	GlobalVar.top_window = GlobalVar.Window.VIDEO_CALL
	GlobalVar.top_window_pos = window_node.get_global_position()
	GlobalVar.top_window_size = window_size
	
	# Raise window to highest z-index
	raise()
