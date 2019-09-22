extends Control

class_name CharInfo

export var active_color : Color
export var inactive_color : Color

onready var CharacterNameLabel: Label = $PanelContainer/NameLabel
onready var CharacterLevelAmount: Label = $LevelAmount
onready var name_scroll : ScrollContainer = $PanelContainer
onready var char_icon = $CharIcon

var character : CharacterInfo = CharacterInfo.new()


var bIsSelected : bool = false;
var previous_scroll : float = 0
var max_time_scroll := 20
var time_passed := 0.0
var scroll_speed := 3
var is_selected_for_quest : bool = false;

var bIsPreScroll : bool = true
var pre_scroll_timer = 2
var pre_scroll_time_passed = 0.0

var bReachedMax : bool = false
var max_scroll_timer = 1
var max_scroll_time_passed = 0.0

signal clicked_char_info(characterInfo,charInfo)

func _ready():
	Initialize(character)


func _process(delta):
	if bIsPreScroll:
		pre_scroll_time_passed += delta
		if pre_scroll_time_passed >= pre_scroll_timer:
			bIsPreScroll = false
			pre_scroll_time_passed = 0.0
	elif bIsSelected and !bReachedMax:
		previous_scroll = name_scroll.scroll_horizontal
		name_scroll.scroll_horizontal += scroll_speed
		if name_scroll.scroll_horizontal == previous_scroll:
			bReachedMax = true
	elif bReachedMax:
		max_scroll_time_passed += delta
		if max_scroll_time_passed > max_scroll_timer:
			max_scroll_time_passed = 0.0
			bReachedMax = false
			bIsPreScroll = true
			name_scroll.scroll_horizontal = 0
			previous_scroll = 0
	
	time_passed += delta
	if time_passed >= max_time_scroll:
		time_passed = 0.0
		bIsSelected = false


func selected_for_party() -> void:
	is_selected_for_quest = true


func unselected_for_party() -> void:
	is_selected_for_quest = false


func Initialize(character: CharacterInfo):
	self.character = character
	CharacterNameLabel.text = character.get_character_name()
	CharacterLevelAmount.text = String(character.get_character_level())
	char_icon.Initialize(character)
	pass

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event  is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("clicked_char_info",character,self)



func _on_Area2D_mouse_entered():
	bIsSelected = true
	time_passed = 0.0
	pre_scroll_time_passed = 0.0
	bIsPreScroll = true
	bReachedMax = false
	max_scroll_time_passed = 0.0


func _on_Area2D_mouse_exited():
	bIsSelected = false
	name_scroll.scroll_horizontal = 0


func _on_CharIcon_mouse_clicked(character : CharacterInfo):
	emit_signal("clicked_char_info", character, self)


func select_for_quest() -> void:
	modulate = inactive_color


func unselect_for_quest() -> void:
	modulate = active_color