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
