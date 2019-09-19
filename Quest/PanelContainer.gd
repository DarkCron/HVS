extends PanelContainer

export var bottom_small_slot : float = -1
export var bottom_medium_slot : float = -1

func _on_QuestSlots_used_medium_slots():
	self.margin_bottom = bottom_medium_slot
	pass # Replace with function body.


func _on_QuestSlots_used_small_slots():
	#self.margin_bottom = bottom_small_slot
	pass # Replace with function body.
