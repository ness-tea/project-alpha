extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


func _on_VideoCallButton_pressed():
	visible = !self.visible


func _on_Close_pressed():
	visible = false


func _on_Accept_pressed():
	visible = true
	get_node("EmptyRoom").visible = false
	if(GlobalVar.timelineDialogueNumber == 1):
		# Start Martin first call dialogue
		var martinDialog = Dialogic.start("FirstMeetingWithMartin")
		add_child(martinDialog)
		martinDialog.connect("timeline_end", self, "after_dialog")
		
	elif(GlobalVar.timelineDialogueNumber == 2):
		# Start Martin second call dialogue
		var martinDialog = Dialogic.start("SecondMeetingWithMartin")
		add_child(martinDialog)
		martinDialog.connect("timeline_end", self, "after_dialog")
		
	elif(GlobalVar.timelineDialogueNumber == 3):
		# Start Martin third call dialogue
		var martinDialog = Dialogic.start("ThirdMeetingWithMartin")
		add_child(martinDialog)
		martinDialog.connect("timeline_end", self, "after_dialog")


func after_dialog(param):
	get_node("EmptyRoom").visible = true
	$"../ProjectAlProgram".makeIconVisible()


func _on_VideoCall_pressed():
	visible = true
