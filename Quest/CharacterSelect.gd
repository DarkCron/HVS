extends Control

class_name CharacterSelect

onready var CharacterListContainer : ScrollContainer = $ScrollContainer
onready var CharacterList : VBoxContainer = $ScrollContainer/VBoxContainer

const character_item_scene = preload("res://Characters/CharInfo.tscn")

export var scroll_speed := 40
var is_in_node := false

signal clicked_on_character(character,charInfo)


func _ready():
	for item in CharacterList.get_children():
		var temp : Node = item
		temp.queue_free()


func Initialize(list : Array) -> void:
	process_characters(list)


func process_characters(list : Array) -> void:
	for item in list:
		var character : CharacterInfo = item
		var temp_char_node = character_item_scene.instance()
		CharacterList.add_child(temp_char_node)
		temp_char_node.Initialize(item)
		temp_char_node.connect("clicked_char_info",self,"_process_clicked_on_charInfo")
		


func _process_clicked_on_charInfo(character : CharacterInfo, charInfo : CharInfo) -> void:
	emit_signal("clicked_on_character",character , charInfo)


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
