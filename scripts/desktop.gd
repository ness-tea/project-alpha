extends Control

var projectAlClick = 0
var projectAlClickTime = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _process(delta):
	if projectAlClick == 1:
		projectAlClickTime += delta
	
	if (projectAlClickTime > 2):
		projectAlClick = 0
		projectAlClickTime = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Logout_pressed():
	get_tree().quit()


func _on_ProjectAlProgram_pressed():
	projectAlClick += 1
	if (projectAlClick == 2 && projectAlClickTime <= 2):
		get_tree().change_scene("res://scenes/al.tscn")
