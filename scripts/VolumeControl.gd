extends Control


onready var volume = $Panel/VSlider

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_VolumeButton_pressed():
	visible = !visible


func _on_VSlider_changed(vol):
	AudioServer.set_bus_volume_db(0,vol) #0 is index #1. Since master is the first in the index, we use 0
