extends Control

onready var quest_info_node = $QuestInfo

var already_selected_characters : Dictionary = {}
var chosen_characters : Dictionary = {}


func _ready():
	#TraitListReader.ProcessTraitList()
	pass


func Reset() -> void:
	for item in already_selected_characters.values():
		var charInfo : CharInfo = item
		charInfo.unselect_for_quest()
	
	already_selected_characters = {}
	chosen_characters = {}


func _on_QuestList_clicked_on_quest(quest : BaseQuest) -> void:
	Reset()
	quest_info_node.Initialize(quest)


func _on_CharacterSelect_clicked_on_character(character : CharacterInfo, charInfo : CharInfo) -> void:
	if already_selected_characters.has(charInfo):
		return
	
	if quest_info_node.has_valid_quest():
		var index : int = quest_info_node.add_char_to_quest(character)
		already_selected_characters[index] = charInfo
		charInfo.select_for_quest()
		chosen_characters[index] = character


func _on_QuestInfo_clicked_on_char_icon(index) -> void:
	if !already_selected_characters.has(index) or already_selected_characters[index] == null:
		return
	
	already_selected_characters[index].unselect_for_quest()
	quest_info_node.clear_index_quest_slot(index)
	already_selected_characters[index] = null
	chosen_characters.erase(index)


func check_if_chosen_characters_accept_quest() -> void:
	for item in chosen_characters.values():
		var character : CharacterInfo = item
		
	pass