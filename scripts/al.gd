extends Control

var alAppearance = Dialogic.get_variable("AlAppearance")
var encounterEnd = Dialogic.get_variable("encounterEnd")

# Called when the node enters the scene tree for the first time.
func _ready():
	if(GlobalVar.timelineDialogueNumber != 4):
		$AudioManager/BackgroundMusic.play()

	if(GlobalVar.timelineDialogueNumber == 1):
		GlobalVar.timelineDialogueNumber = 2
		var alDialog1 = Dialogic.start("FirstEncounterWithAl")
		dialogic_after_dialog_set(alDialog1)
	elif(GlobalVar.timelineDialogueNumber == 2):
		GlobalVar.timelineDialogueNumber = 3
		if(alAppearance=="male"):
			var alDialog1 = Dialogic.start("SecondEncounterWithAlMale")
			dialogic_after_dialog_set(alDialog1)
		elif(alAppearance=="hair"):
			var alDialog1 = Dialogic.start("SecondEncounterWithAlHair")
			dialogic_after_dialog_set(alDialog1)
		elif(alAppearance=="eyes"):
			var alDialog1 = Dialogic.start("SecondEncounterWithAlEyes")
			dialogic_after_dialog_set(alDialog1)
		else:
			var alDialog1 = Dialogic.start("SecondEncounterWithAl")
			dialogic_after_dialog_set(alDialog1)
	elif(GlobalVar.timelineDialogueNumber == 4):
		$AudioManager/EvilBackgroundMusic.play()
		var alDialog1 = Dialogic.start("ThirdEncounterWithAl")
		add_child(alDialog1)
		alDialog1.connect("timeline_end", self, "blackout_screen")

#Used to add child and connect between timeline ends and what to do next
func dialogic_after_dialog_set(alDialog1):
	add_child(alDialog1)
	alDialog1.connect("timeline_end", self, "after_dialog")

func after_dialog(_param):
	get_tree().change_scene("res://scenes/desktop.tscn")


func blackout_screen(_param):
	for m in 3:
		$BlackoutScreen.visible = true
		yield(get_tree().create_timer(0.3), "timeout")
		$AIGlitch1.visible = true
		$BlackoutScreen.visible = false
		yield(get_tree().create_timer(0.3), "timeout")
	$AudioManager/CreepyLaugh.play()
	for n in 3:
		$BlackoutScreen.visible = true
		yield(get_tree().create_timer(0.3), "timeout")
		$AIGlitch2
		$BlackoutScreen.visible = false
		yield(get_tree().create_timer(0.3), "timeout")
	$AIGlitch1.visible = false
	$AIGlitch2.visible = false
	$BlackoutScreen.visible = true
	yield(get_tree().create_timer(2), "timeout")
	GlobalVar.gameEndCondition = true
	get_tree().change_scene("res://scenes/login.tscn")
