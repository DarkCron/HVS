extends Button

export var medium_pos : Vector2
export var small_ps : Vector2

func _on_QuestSlots_used_small_slots():
	rect_position = small_ps
	pass # Replace with function body.


func _on_QuestSlots_used_medium_slots():
	rect_position = medium_pos
	pass # Replace with function body.
