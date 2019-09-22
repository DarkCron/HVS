extends Control

class_name QuestItem

onready var title_scroll : ScrollContainer = $ScrollContainer
onready var quest_title_label : Label = $ScrollContainer/Label
onready var quest_icon = $ColorRect/QuestIcon
onready var quest_selection_box = $SelectionRect

export var not_selected_color : Color

var bIsSelected : bool = false;
var previous_scroll : float = 0
var max_time_scroll := 10
var time_passed := 0.0
var quest_info : BaseQuest

signal clicked_on_quest_preview

func Initialize(quest : BaseQuest):
	var quest_level = quest.quest_level
	var temp_string = "[" + String(quest_level) + "] " + quest.quest_title
	quest_title_label.text = temp_string
	quest_icon.Initialize(quest)
	quest_info = quest
	pass


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


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("clicked_on_quest_preview",quest_info)


func select_this() -> void:
	quest_selection_box.visible = true
	modulate = Color.white


func unselect_this() -> void:
	quest_selection_box.visible = false
	modulate = not_selected_color