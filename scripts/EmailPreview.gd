extends Panel


var firstClickEE1:bool = false
var firstClickEE2:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func hide_email_previews():
	for N in get_children():
		N.visible = false

func _on_Email_pressed():
	hide_email_previews()
	$EmailPreview.visible = true

func _on_Email2_pressed():
	hide_email_previews()
	$Email2Preview.visible = true


func _on_Email3_pressed():
	hide_email_previews()
	$Email3Preview.visible = true


func _on_Email4_pressed():
	hide_email_previews()
	$Email4Preview.visible = true


func _on_Email5_pressed():
	hide_email_previews()
	$Email5Preview.visible = true


func _on_Email6_pressed():
	hide_email_previews()
	$Email6Preview.visible = true


func _on_EmailEnd1_pressed():
	hide_email_previews()
	$EmailEnd1Preview.visible = true

func _on_EmailEnd2_pressed():
	hide_email_previews()
	$EmailEnd2Preview.visible = true
