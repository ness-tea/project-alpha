extends Control

onready var musicVolume: VSlider = $Panel/MusicSlider
var musicBus = AudioServer.get_bus_index("Music")


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	#volume.value = GlobalVar.masterVolume
	if GlobalVar.musicVolume != null:
		set_slider_position(GlobalVar.musicVolume)


func _on_Button_pressed():
	ClickSound.play()
	visible = !visible


func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(musicBus,value)
	GlobalVar.musicVolume = value


func set_slider_position(position: float) -> void:
	position = clamp(position,-80,24)
	if musicVolume != null:
		musicVolume.value = position

