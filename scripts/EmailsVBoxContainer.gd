extends VBoxContainer


# Declare member variables here. Examples:
var lastEmail
var readStyleBox


# Called when the node enters the scene tree for the first time.
func _ready():
	lastEmail = $Email6
	readStyleBox = $Email6.get_stylebox("normal").duplicate()
	
	
	if(GlobalVar.timelineDialogueNumber == 4):
		$EmailEnd1.visible = true
		$EmailEnd2.visible = true
		$"../../../TaskbarPanel/EmailNotif".visible = true
	else:
		$EmailEnd1.visible = false
		$EmailEnd2.visible = false
	
	if (GlobalVar.emailRead):
		mark_Email_Read($Email, $Email/Label)
		
	if (GlobalVar.email2Read):
		mark_Email_Read($Email2, $Email2/Label)
		
	if (GlobalVar.email3Read):
		mark_Email_Read($Email3, $Email3/Label)


func _on_Email_pressed():
	GlobalVar.emailRead = true
	lastEmail = $Email
	mark_Email_Read($Email, $Email/Label)

func _on_Email2_pressed():
	GlobalVar.email2Read = true
	lastEmail = $Email2
	mark_Email_Read($Email2, $Email2/Label)

func _on_Email3_pressed():
	GlobalVar.email3Read = true
	lastEmail = $Email3	
	mark_Email_Read($Email3, $Email3/Label)

func _on_Email4_pressed():
	lastEmail = $Email4


func _on_Email5_pressed():
	lastEmail = $Email5


func _on_Email6_pressed():
	lastEmail = $Email6


func _on_EmailsButton_pressed():
	lastEmail.grab_focus()


func _on_EmailEnd1_pressed():
	lastEmail = $EmailEnd1
	mark_Email_Read($EmailEnd1, $EmailEnd1/Label)
	GlobalVar.emailEnd1Read = true
	emailNotif()


func _on_EmailEnd2_pressed():
	lastEmail = $EmailEnd2
	mark_Email_Read($EmailEnd2, $EmailEnd2/Label)
	GlobalVar.emailEnd2Read = true
	emailNotif()


func mark_Email_Read(_email, _label):
	_email.add_stylebox_override("normal", readStyleBox)
	_label.add_color_override("font_color", Color("#101010"))
	emailNotif()


func emailNotif():
	if($EmailEnd1.visible == false && (GlobalVar.emailRead == true && GlobalVar.email2Read == true && GlobalVar.email3Read == true)):
		$"../../../TaskbarPanel/EmailNotif".visible = false
	if(GlobalVar.emailEnd1Read == true && GlobalVar.emailEnd2Read == true):
		$"../../../TaskbarPanel/EmailNotif".visible = false
