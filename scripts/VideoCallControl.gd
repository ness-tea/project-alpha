extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VideoCallButton_pressed():
	visible = !self.visible


func _on_Close_pressed():
	visible = false


func _on_Accept_pressed():
	visible = true
	get_node("EmptyRoom").visible = false
	
	# Start Martin first call dialogue
	var martinDialog = Dialogic.start("FirstMeetingWithMartin")
	add_child(martinDialog)
	martinDialog.connect("timeline_end", self, "after_dialog")
	
func after_dialog(param):
	get_node("EmptyRoom").visible = true
