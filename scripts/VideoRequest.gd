extends Control

# Declare member variables here. Examples:
var firstRequest = true
var declined = false
var soundTimer = 0
var firstRing = true


# Called when the node enters the scene tree for the first time.
func _ready():
	if(GlobalVar.timelineDialogueNumber != 4):
		$Panel/Label.text = "Martin is calling..."
	else:
		$Panel/Label.text = "Unknown is calling..."
	visible = false
	if(GlobalVar.timelineDialogueNumber == 2 or GlobalVar.timelineDialogueNumber == 3 or GlobalVar.timelineDialogueNumber == 4):
		if firstRequest:
			firstRequest = false
			yield(get_tree().create_timer(5.0), "timeout")
			visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Sound timer and ringing of the video call
	soundTimer += delta
	if($".".visible and firstRing):
		firstRing = false
		$"../AudioManager/VideoCallPlayer".play()
	elif($".".visible and soundTimer>1.5):
		soundTimer = 0
		$"../AudioManager/VideoCallPlayer".play()
	elif($".".visible == false):
		soundTimer = 0
		$"../AudioManager/VideoCallPlayer".stop()
	
	# If player declines Martin's call, keep requests coming in every 3 seconds until player accepts it.
	if declined:
		ClickSound.play()
		declined = false
		yield(get_tree().create_timer(3.0), "timeout")
		visible = true


func _on_Accept_pressed():
	ClickSound.play()
	declined = false
	visible = false
	firstRing = true


func _on_Decline_pressed():
	ClickSound.play()
	declined = true
	Dialogic.set_variable("declined", 1)
	visible = false
	firstRing = true


func _on_Email2_pressed():
	# Only trigger Martin's call once player finds Martin's email for the first time.
	if(GlobalVar.timelineDialogueNumber == null):
		GlobalVar.timelineDialogueNumber = 1
	if firstRequest:
		firstRequest = false
		yield(get_tree().create_timer(5.0), "timeout")
		visible = true
