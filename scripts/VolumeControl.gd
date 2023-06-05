extends Control

onready var volume: VSlider = $Panel/VolumeSlider
var masterBus = AudioServer.get_bus_index("Master")


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	#volume.value = GlobalVar.masterVolume
	if GlobalVar.masterVolume != null:
		set_slider_position(GlobalVar.masterVolume)


func _on_VolumeButton_pressed():
	visible = !visible

#-40 t0 24
func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(masterBus,value)
	GlobalVar.masterVolume = value


func set_slider_position(position: float) -> void:
	position = clamp(position,-40,24)
	if volume != null:
		volume.value = position
