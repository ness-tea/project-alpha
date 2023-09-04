extends ScrollContainer

var max_scroll_length = 0
onready var scrollbar = self.get_v_scrollbar()

func _ready():
	#Starts scrollbar at bottom to show latest messages when opening the app
	if max_scroll_length != scrollbar.max_value: 
		max_scroll_length = scrollbar.max_value
		self.scroll_vertical = max_scroll_length
	max_scroll_length = scrollbar.max_value
