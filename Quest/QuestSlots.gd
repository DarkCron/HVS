extends Node2D

onready var Small_Slots : Sprite = $small_quest_slot
onready var Medium_Slots : Sprite = $medium_quest_slot

signal used_small_slots
signal used_medium_slots

func set_small_quest_slot() -> void:
	Small_Slots.visible = true
	Medium_Slots.visible = false
	emit_signal('used_small_slots')


func set_medium_quest_slot() -> void:
	Small_Slots.visible = false
	Medium_Slots.visible = true
	emit_signal('used_medium_slots')