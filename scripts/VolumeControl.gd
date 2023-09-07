extends Control

#used for Sound control
onready var volume: VSlider = $Panel/VolumeSlider
var soundBus = AudioServer.get_bus_index("Sounds")


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	#volume.value = GlobalVar.masterVolume
	if GlobalVar.soundVolume != null:
		set_slider_position(GlobalVar.soundVolume)


func _on_VolumeButton_pressed():
	ClickSound.play()
	visible = !visible

#-80 t0 24
func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(soundBus,value)
	GlobalVar.soundVolume = value


func set_slider_position(position: float) -> void:
	position = clamp(position,-80,24)
	if volume != null:
		volume.value = position
