extends Control

onready var quest_info_node = $QuestInfo
onready var quest_reward_node = $QuestReward
onready var character_select = $CharacterSelect
onready var quest_select = $QuestList

var already_selected_characters : Dictionary = {}
var chosen_characters : Dictionary = {}
var chosen_quest_rewards: Dictionary = {}
var amount_of_chosen_characters := 0

func _ready():
	#TraitListReader.ProcessTraitList()
	Initialize([CharacterInfo.generate_random_char(CharacterInfo.new()),
	 CharacterInfo.generate_random_char(CharacterInfo.new()),
	CharacterInfo.generate_random_char(CharacterInfo.new())],
	[BaseQuest.test_random_quest(BaseQuest.new()),
	BaseQuest.test_random_quest(BaseQuest.new())])
	pass


func Initialize(characters: Array, quests : Array) -> void:
	#TODO: Select only available characters
	character_select.Initialize(characters)
	quest_select.Initialize(quests)


func Reset() -> void:
	for item in already_selected_characters.values():
		var charInfo : CharInfo = item
		charInfo.unselect_for_quest()
	
	already_selected_characters = {}
	chosen_characters = {}
	chosen_quest_rewards = {}
	amount_of_chosen_characters = 0


func _on_QuestList_clicked_on_quest(quest : BaseQuest) -> void:
	Reset()
	quest_info_node.Initialize(quest)
	quest_reward_node.Reset()


func _on_CharacterSelect_clicked_on_character(character : CharacterInfo, charInfo : CharInfo) -> void:
	if already_selected_characters.values().has(charInfo):
		return
	
	if quest_info_node.has_valid_quest():
		var index : int = quest_info_node.add_char_to_quest(character)
		already_selected_characters[index] = charInfo
		charInfo.select_for_quest()
		chosen_characters[index] = character
		_on_character_added_to_quest_slot()


func _on_QuestInfo_clicked_on_char_icon(index) -> void:
	if !already_selected_characters.has(index) or already_selected_characters[index] == null:
		return
	
	already_selected_characters[index].unselect_for_quest()
	quest_info_node.clear_index_quest_slot(index)
	already_selected_characters[index] = null
	chosen_characters.erase(index)
	_on_character_removed_to_quest_slot()


func check_if_chosen_characters_accept_quest() -> void:
	for item in chosen_characters.values():
		var character : CharacterInfo = item
		
	pass


func _on_QuestReward_selected_items_changed(item_type, item_info, is_selected):
	match item_type:
		BaseItem.ITEM_TYPE.WEAPON:
			#print("Weapon: "+ item_info + " "+ String(is_selected))
			chosen_quest_rewards[item_type] = item_info
			print(BaseItem.item_collection[item_info])
		BaseItem.ITEM_TYPE.ARMOUR:
			#print("Armour: "+ item_info + " "+ String(is_selected))
			chosen_quest_rewards[item_type] = item_info
			print(BaseItem.item_collection[item_info])
		BaseItem.ITEM_TYPE.POTION:
			#print("Potion: "+ item_info + " "+ String(is_selected))
			print(BaseItem.item_collection[item_info])
	pass # Replace with function body.


func _on_character_added_to_quest_slot() -> void:
	amount_of_chosen_characters += 1
	update_quest_reward_characters()


func _on_character_removed_to_quest_slot() -> void:
	amount_of_chosen_characters -= 1
	assert(amount_of_chosen_characters >= 0)
	update_quest_reward_characters()


func update_quest_reward_characters() -> void:
	quest_reward_node.set_amount_of_players_to_reward(amount_of_chosen_characters)

func _on_QuestReward_quest_value_changed(amount : int):
	for character in chosen_characters.values():
		if (character as CharacterInfo).does_character_accept_value(amount):
			quest_info_node.set_character_availabe(character)
		else:
			quest_info_node.set_character_unavailabe(character)