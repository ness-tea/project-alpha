extends CanvasLayer


func _ready():
	yield(get_tree().create_timer(2.0), "timeout")
	SceneTransition.change_scene("res://scenes/login.tscn")
