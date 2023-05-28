extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	if(GlobalVar.timelineDialogueNumber == 1):
		GlobalVar.timelineDialogueNumber = 2
		var alDialog1 = Dialogic.start("FirstEncounterWithAl")
		add_child(alDialog1)
		alDialog1.connect("timeline_end", self, "after_dialog")
	elif(GlobalVar.timelineDialogueNumber == 2):
		GlobalVar.timelineDialogueNumber = 3
		var alDialog1 = Dialogic.start("SecondEncounterWithAl")
		add_child(alDialog1)
		alDialog1.connect("timeline_end", self, "after_dialog")
	elif(GlobalVar.timelineDialogueNumber == 3):
		var alDialog1 = Dialogic.start("ThirdEncounterWithAl")
		add_child(alDialog1)
		alDialog1.connect("timeline_end", self, "after_dialog")

func after_dialog(_param):
	get_tree().change_scene("res://scenes/desktop.tscn")
