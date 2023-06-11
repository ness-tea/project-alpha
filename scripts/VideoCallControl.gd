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


func after_dialog(_param):
	get_node("EmptyRoom").visible = true
	$"../ProjectAlProgram".makeIconVisible()


func _on_VideoCall_pressed():
	ClickSound.play()
	visible = true

func dialogic_additional_functions(martinDialog):
	add_child(martinDialog)
	martinDialog.connect("timeline_end", self, "after_dialog")
