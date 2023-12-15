extends Label
# Purpose of script is to ensure time is always up to date

var time = OS.get_time()
var time_return: String

var emailHour = time.hour - 1
var emailMin = time.minute

# Called when the node enters the scene tree for the first time.
func _ready():
	if(time.minute >10):
		emailMin = (time.minute - 8)
	else:
		time_return = String(time.hour) +":"+"0"+String(time.minute)
	time_return = String(emailHour) +":"+String(emailMin)
	text = time_return


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(time.minute >10):
		emailMin = (time.minute - 8)
	else:
		time_return = String(time.hour) +":"+"0"+String(time.minute)
	time_return = String(emailHour) +":"+String(emailMin)
	text = time_return
