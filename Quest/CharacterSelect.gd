extends Control

onready var CharacterListContainer : ScrollContainer = $ScrollContainer

export var scroll_speed := 40
var is_in_node := false

func _unhandled_input(event):
	if !is_in_node:
		return
	
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_WHEEL_DOWN :
		CharacterListContainer.scroll_vertical += scroll_speed
	
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_WHEEL_UP :
		CharacterListContainer.scroll_vertical -= scroll_speed

func _on_Area2D_mouse_entered():
	is_in_node = true


func _on_Area2D_mouse_exited():
	is_in_node = false
