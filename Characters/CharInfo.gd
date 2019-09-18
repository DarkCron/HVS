extends Control

export var active_color : Color
export var inactive_color : Color

onready var CharacterNameLabel: Label = $PanelContainer/NameLabel
onready var CharacterLevelAmount: Label = $LevelAmount
onready var name_scroll : ScrollContainer = $PanelContainer

var character : CharacterInfo = CharacterInfo.new()


var bIsSelected : bool = false;
var previous_scroll : float = 0
var max_time_scroll := 10
var time_passed := 0.0
var scroll_speed := 1
var is_selected_for_quest : bool = false;

signal clicked_char_info

func _ready():
	Initialize(character)


func _process(delta):
	if bIsSelected:
		time_passed += delta
		previous_scroll = name_scroll.scroll_horizontal
		name_scroll.scroll_horizontal += scroll_speed
		if name_scroll.scroll_horizontal == previous_scroll:
			name_scroll.scroll_horizontal = 0
			previous_scroll = 0
		
		if time_passed >= max_time_scroll:
			bIsSelected = false


func selected_for_party() -> void:
	is_selected_for_quest = true


func unselected_for_party() -> void:
	is_selected_for_quest = false


func Initialize(character: CharacterInfo):
	CharacterNameLabel.text = character.get_character_name()
	CharacterLevelAmount.text = String(character.get_character_level())
	pass

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event  is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("clicked_char_info")



func _on_Area2D_mouse_entered():
	bIsSelected = true
	time_passed = 0.0


func _on_Area2D_mouse_exited():
	bIsSelected = false
	name_scroll.scroll_horizontal = 0
