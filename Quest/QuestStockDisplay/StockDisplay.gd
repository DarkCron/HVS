extends Control

export var collapsed_position : Vector2
export var extended_position : Vector2

onready var blacksmith_items_node = $ScrollContainer/ItemStock/BlacksmithStockDisplay
onready var alchemist_items_node = $ScrollContainer/ItemStock/AlchemistStockDisplay

onready var open_close_button = $OpenCloseButton

var is_collapsed :=  true

func update_labels() -> void:
	blacksmith_items_node.update_labels()
	alchemist_items_node.update_labels()

func _on_OpenCloseButton_pressed():
	if is_collapsed:
		#opens panel
		update_labels()
		is_collapsed = false
		self.rect_position = extended_position
		open_close_button.text = ">"
	else:
		#closes panel
		is_collapsed = true
		self.rect_position = collapsed_position
		open_close_button.text = "<"