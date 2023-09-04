extends Node

#Global settings page to keep data saved

var timelineDialogueNumber
var masterVolume

var jamieMessageShown = 0 #Includes Jamie and Player messages. Jamie = 1, Player = 2, Jamie = 3, etc.

var emailRead = false
var email2Read = false
var email3Read = false

# Window handling
enum State {NONE, WINDOW_CLICKED, TITLEBAR_CLICKED, DRAGGING, RELEASED}
enum Window {NONE, EMAILS, MESSENGER, VIDEO_CALL}
var top_window = Window.NONE
var top_window_pos
var top_window_size

func _ready():
	pass # Replace with function body.

# Debugging Helpers
func _print_top_window():
	match top_window:
		Window.NONE:
			return "NONE"
		Window.EMAILS:
			return "EMAIL"
		Window.MESSENGER:
			return "MESSENGER"
		Window.VIDEO_CALL:
			return "VIDEO CALL"