extends ScrollContainer

export var scroll_speed := 40

var is_in_node := false

func _unhandled_input(event) -> void:
	if !is_in_node:
		return
	
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_WHEEL_DOWN :
		self.scroll_vertical += scroll_speed
	
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_WHEEL_UP :
		self.scroll_vertical -= scroll_speed


func _on_Area2D_mouse_entered():
	is_in_node = true


func _on_Area2D_mouse_exited():
	is_in_node = false
