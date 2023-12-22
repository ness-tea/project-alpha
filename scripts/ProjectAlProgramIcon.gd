extends Button
 

func _ready():
	$".".visible = false

func makeIconVisible():
	$".".visible = true

func makeIconNotVisible():
	$".".visible = false
