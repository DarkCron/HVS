extends Node2D

class_name QuestSlots

onready var Small_Slots : Sprite = $small_quest_slot
onready var Medium_Slots : Sprite = $medium_quest_slot

var icon_list : Array = []

var characterInfo_to_icon : Dictionary = {}

var small_slot_indices : Dictionary = {}
var medium_slot_indices : Dictionary = {}

signal used_small_slots
signal used_medium_slots

signal clicked_on_icon(index)

func _ready():
	$small_quest_slot/CharIcon.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$small_quest_slot/CharIcon2.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$small_quest_slot/CharIcon3.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$small_quest_slot/CharIcon4.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$small_quest_slot/CharIcon5.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$small_quest_slot/CharIcon6.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")

	small_slot_indices[$small_quest_slot/CharIcon] = 0
	small_slot_indices[$small_quest_slot/CharIcon2] = 1
	small_slot_indices[$small_quest_slot/CharIcon3] = 2
	small_slot_indices[$small_quest_slot/CharIcon4] = 3
	small_slot_indices[$small_quest_slot/CharIcon5] = 4
	small_slot_indices[$small_quest_slot/CharIcon6] = 5
	
	icon_list.append($small_quest_slot/CharIcon)
	icon_list.append($small_quest_slot/CharIcon2)
	icon_list.append($small_quest_slot/CharIcon3)
	icon_list.append($small_quest_slot/CharIcon4)
	icon_list.append($small_quest_slot/CharIcon5)
	icon_list.append($small_quest_slot/CharIcon6)
	
	$medium_quest_slot/CharIcon1.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$medium_quest_slot/CharIcon2.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$medium_quest_slot/CharIcon3.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$medium_quest_slot/CharIcon4.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$medium_quest_slot/CharIcon5.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$medium_quest_slot/CharIcon6.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$medium_quest_slot/CharIcon7.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$medium_quest_slot/CharIcon8.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$medium_quest_slot/CharIcon9.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$medium_quest_slot/CharIcon10.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$medium_quest_slot/CharIcon11.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	$medium_quest_slot/CharIcon12.connect("mouse_clicked_charIcon", self, "_on_CharIcon_mouse_clicked_charIcon")
	
	medium_slot_indices[$medium_quest_slot/CharIcon1] = 0
	medium_slot_indices[$medium_quest_slot/CharIcon2] = 1
	medium_slot_indices[$medium_quest_slot/CharIcon3] = 2
	medium_slot_indices[$medium_quest_slot/CharIcon4] = 3
	medium_slot_indices[$medium_quest_slot/CharIcon5] = 4
	medium_slot_indices[$medium_quest_slot/CharIcon6] = 5
	medium_slot_indices[$medium_quest_slot/CharIcon7] = 6
	medium_slot_indices[$medium_quest_slot/CharIcon8] = 7
	medium_slot_indices[$medium_quest_slot/CharIcon9] = 8
	medium_slot_indices[$medium_quest_slot/CharIcon10] = 9
	medium_slot_indices[$medium_quest_slot/CharIcon11] = 10
	medium_slot_indices[$medium_quest_slot/CharIcon12] = 11
	
	icon_list.append($medium_quest_slot/CharIcon1)
	icon_list.append($medium_quest_slot/CharIcon2)
	icon_list.append($medium_quest_slot/CharIcon3)
	icon_list.append($medium_quest_slot/CharIcon4)
	icon_list.append($medium_quest_slot/CharIcon5)
	icon_list.append($medium_quest_slot/CharIcon6)
	icon_list.append($medium_quest_slot/CharIcon7)
	icon_list.append($medium_quest_slot/CharIcon8)
	icon_list.append($medium_quest_slot/CharIcon9)
	icon_list.append($medium_quest_slot/CharIcon10)
	icon_list.append($medium_quest_slot/CharIcon11)
	icon_list.append($medium_quest_slot/CharIcon12)
	
	clear_char_icons()


func set_small_quest_slot() -> void:
	Small_Slots.visible = true
	Medium_Slots.visible = false
	emit_signal('used_small_slots')


func set_medium_quest_slot() -> void:
	Small_Slots.visible = false
	Medium_Slots.visible = true
	emit_signal('used_medium_slots')


func _on_CharIcon_mouse_clicked_charIcon(charIcon):
	if Small_Slots.visible:
		#print(String(small_slot_indices[charIcon]))
		emit_signal("clicked_on_icon", small_slot_indices[charIcon])
	elif Medium_Slots.visible:
		#print(String(medium_slot_indices[charIcon]))
		emit_signal("clicked_on_icon", medium_slot_indices[charIcon])


func clear_char_icons() -> void:
	for item in icon_list:
		var icon : CharIcon = item
		icon.ClearIcon()
		icon.visible = false
	characterInfo_to_icon.clear()


func has_free_slots() -> bool:
	if Small_Slots.visible:
		for item in small_slot_indices.keys():
			var charIcon : CharIcon = item
			if !charIcon.visible:
				return true
	elif Medium_Slots.visible:
		for item in medium_slot_indices.keys():
			var charIcon : CharIcon = item
			if !charIcon.visible:
				return true
	return false


func add_character(character : CharacterInfo) -> int:
	if Small_Slots.visible:
		for item in small_slot_indices.keys():
			var charIcon : CharIcon = item
			if !charIcon.visible:
				charIcon.Initialize(character)
				charIcon.enable_quest_slot_features()
				charIcon.visible = true
				characterInfo_to_icon[character] = charIcon
				return small_slot_indices[charIcon]
	elif Medium_Slots.visible:
		for item in medium_slot_indices.keys():
			var charIcon : CharIcon = item
			if !charIcon.visible:
				charIcon.Initialize(character)
				charIcon.enable_quest_slot_features()
				charIcon.visible = true
				characterInfo_to_icon[character] = charIcon
				return medium_slot_indices[charIcon]
	return -1


func clear_index_slot_icon(index : int) -> void:
	if Small_Slots.visible:
		for item in small_slot_indices.keys():
			if small_slot_indices[item] == index:
				(item as CharIcon).ClearIcon()
				(item as CharIcon).visible = false
				for icon in characterInfo_to_icon.keys():
					if !characterInfo_to_icon[icon].visible:
						characterInfo_to_icon.erase(icon)
						break
	elif Medium_Slots.visible:
		for item in medium_slot_indices.keys():
			if medium_slot_indices[item] == index:
				(item as CharIcon).ClearIcon()
				(item as CharIcon).visible = false
				for icon in characterInfo_to_icon.keys():
					if !characterInfo_to_icon[icon].visible:
						characterInfo_to_icon.erase(icon)
						break


func set_character_available(character : CharacterInfo) -> void:
	(characterInfo_to_icon[character] as CharIcon).set_char_available()


func set_character_unavailable(character : CharacterInfo) -> void:
	(characterInfo_to_icon[character] as CharIcon).set_char_unavailable()