extends Button
 

func _ready():
	$".".visible = false

func makeIconVisible():
	yield(get_tree().create_timer(1.0), "timeout")
	$".".visible = true

func makeIconNotVisible():
	$".".visible = false
