extends Control

onready var title_scroll : ScrollContainer = $ScrollContainer

var bIsSelected : bool = false;
var previous_scroll : float = 0
var max_time_scroll := 10
var time_passed := 0.0

func _process(delta):
	if bIsSelected:
		time_passed += delta
		previous_scroll = title_scroll.scroll_horizontal
		title_scroll.scroll_horizontal += 3
		if title_scroll.scroll_horizontal == previous_scroll:
			title_scroll.scroll_horizontal = 0
			previous_scroll = 0
		
		if time_passed >= max_time_scroll:
			bIsSelected = false

func _on_Area2D_mouse_entered():
	bIsSelected = true
	time_passed = 0.0
	pass # Replace with function body.


func _on_Area2D_mouse_exited():
	bIsSelected = false
	title_scroll.scroll_horizontal = 0
	pass # Replace with function body.
