extends WindowDialog

export var popup_position : Vector2 

func _on_WindowDialog_about_to_show():
	self.rect_position = popup_position
	pass # Replace with function body.
