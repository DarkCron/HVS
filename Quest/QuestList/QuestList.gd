extends ScrollContainer

onready var quest_list_node : VBoxContainer = $VBoxContainer

export var scroll_speed := 40

var is_in_node := false

const quest_item_scene = preload("res://Quest/QuestList/QuestItem/QuestItem.tscn")

signal clicked_on_quest

func _ready():
	for item in $VBoxContainer.get_children():
		item.queue_free()
	process_quest_array([BaseQuest.new()])

func process_quest_array(list : Array) -> void:
	for item in list:
		var quest : BaseQuest = item
		var quest_item_node : Node = quest_item_scene.instance()
		quest_list_node.add_child(quest_item_node)
		quest_item_node.Initialize(quest)
		quest_item_node.connect("clicked_on_quest_preview",self,"_on_quest_item_click")


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


func _on_quest_item_click(quest : BaseQuest) -> void:
	emit_signal("clicked_on_quest",quest)