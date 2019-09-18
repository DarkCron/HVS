extends Node2D

onready var traitsPopup : PopupDialog = $CharacterTraitList
onready var character_available_icon : AnimatedSprite = $CharAvailable
onready var character_role_icon : AnimatedSprite = $Icon

onready var Set1 : Sprite = $BGPanel/Set1
onready var Set2 : Sprite = $BGPanel/Set2
onready var Set3 : Sprite = $BGPanel/Set3
onready var Set4 : Sprite = $BGPanel/Set4

onready var Icon : AnimatedSprite = $Icon

onready var Collider : Area2D = $Area2D

var character : CharacterInfo = CharacterInfo.new()


var popupTimer : float = 1.0
var popupTimerElapsedTime : float = 0.0
var startPopupTimer : bool = false

signal mouse_clicked
signal mouse_entered
signal mouse_left


func Initialize(value: CharacterInfo) -> void:
	self.character = value
	pass


func added_char_to_quest() -> void:
	character_available_icon.visible = true


func removed_char_to_quest() -> void:
	character_available_icon.visible = false


func set_char_available() -> void:
	character_available_icon.frame = 1


func set_char_unavailable() -> void:
	character_available_icon.frame = 0


func _ready():
	randomize()
	randomize()
	randomize()
	
	Set1.visible = false
	Set2.visible = false
	Set3.visible = false
	Set4.visible = false
	
	#_random_portrait_gen()
	#Icon.frame = rand_range(0,3)
	pass


func set_icon_from_icon(character : CharacterInfo) -> void:
	Set1.visible = false
	Set2.visible = false
	Set3.visible = false
	Set4.visible = false
	
	var set = character.character_icon_set
	var selectedSet : Sprite
	if set == 1:
		selectedSet = Set1
	elif set == 2:
		selectedSet = Set2
	elif set == 3:
		selectedSet = Set3
	else:
		selectedSet = Set4
	
	selectedSet.visible = true
	
	selectedSet.frame = character.character_icon_frame
	
	var role = character.character_role
	var role_frame = 0
	match role:
		CharacterInfo.CLASS_ROLE.DPS:
			role_frame = 0
		CharacterInfo.CLASS_ROLE.HEALER:
			role_frame = 1
		CharacterInfo.CLASS_ROLE.TANK:
			role_frame = 2
	
	character_role_icon.frame = role_frame
	character_role_icon.visible = true


func _random_portrait_gen() -> void:	
	var set : int = rand_range(1,4)
	
	var selectedSet : Sprite
	if set == 1:
		selectedSet = Set1
	elif set == 2:
		selectedSet = Set2
	elif set == 3:
		selectedSet = Set3
	else:
		selectedSet = Set4
	
	selectedSet.visible = true
	
	selectedSet.frame = rand_range(0 , selectedSet.vframes * selectedSet.hframes)


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_random_portrait_gen()
	
	if startPopupTimer:
		popupTimerElapsedTime += delta
	
	if popupTimerElapsedTime > popupTimer and !traitsPopup.visible:
		traitsPopup.popup()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouse and event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("mouse_clicked")


func _on_Area2D_mouse_entered():
	emit_signal("mouse_entered")
	#print(666)


func _on_Area2D_mouse_exited():
	emit_signal("mouse_left")
	#print(666)


func _on_CharIcon_mouse_clicked():
	pass


func _on_CharIcon_mouse_entered():
	startPopupTimer = true


func _on_CharIcon_mouse_left():
	ResetPopup()


func ResetPopup():
	popupTimerElapsedTime = 0.0
	startPopupTimer = false
	$CharacterTraitList.hide()
