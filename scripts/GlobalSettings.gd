extends Node

#Global settings page to keep data saved

var timelineDialogueNumber
var masterVolume

var emailRead = false
var email2Read = false
var email3Read = false

enum Window {NONE, EMAILS, MESSENGER, VIDEO_CALL}
var top_window = Window.NONE
var top_window_pos
var top_window_size

func _ready():
	pass # Replace with function body.

func _print_top_window():
	if (top_window == Window.NONE):
		return "NONE"
	if (top_window == Window.EMAILS):
		return "EMAIL"
	if (top_window == Window.MESSENGER):
		return "MESSENGER"
	if (top_window == Window.VIDEO_CALL):
		return "VIDEO CALL"		
