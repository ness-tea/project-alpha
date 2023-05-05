extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var alDialog1 = Dialogic.start("FirstEncounterWithAl")
	add_child(alDialog1)
	alDialog1.connect("timeline_end", self, "after_dialog")


func after_dialog(param):
	GlobalVar.timelineDialogueNumber = 2
	get_tree().change_scene("res://scenes/desktop.tscn")
