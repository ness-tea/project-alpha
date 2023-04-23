extends VBoxContainer


# Declare member variables here. Examples:
var lastEmail
var readStyleBox


# Called when the node enters the scene tree for the first time.
func _ready():
	lastEmail = $Email6
	readStyleBox = $Email6.get_stylebox("normal").duplicate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Email_pressed():
	lastEmail = $Email
	
	# Mark email as read
	$Email.add_stylebox_override("normal", readStyleBox)
	$Email/Label.add_color_override("font_color", Color("#101010"))


func _on_Email2_pressed():
	lastEmail = $Email2
	$Email2.add_stylebox_override("normal", readStyleBox)
	$Email2/Label.add_color_override("font_color", Color("#101010"))

func _on_Email3_pressed():
	lastEmail = $Email3
	$Email3.add_stylebox_override("normal", readStyleBox)
	$Email3/Label.add_color_override("font_color", Color("#101010"))


func _on_Email4_pressed():
	lastEmail = $Email4


func _on_Email5_pressed():
	lastEmail = $Email5


func _on_Email6_pressed():
	lastEmail = $Email6



func _on_EmailsButton_pressed():
	lastEmail.grab_focus()
