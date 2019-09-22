extends Control

class_name QuestInfo

onready var questslots_node : QuestSlots = $QuestSlots
onready var quest_description = $PanelContainer/RichTextLabel
onready var quest_title = $Label
onready var error_pop_up = $ErrorPopup
onready var renown_label_amount = $Label3
onready var quest_percentage = $TextureProgress

var selected_quest : BaseQuest = null

signal clicked_on_char_icon(index)
signal pressed_contract_button

func _ready():
	questslots_node.set_small_quest_slot()
	quest_description.text = ""
	quest_title.text = ""
	renown_label_amount.text = "0"


func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and true:
		var temp = $QuestSlots
		if int(rand_range(0,2)) == 0 :
			temp.set_small_quest_slot()
		else:
			temp.set_medium_quest_slot()
		(error_pop_up as Popup).popup()
		error_pop_up.Initialize()


func Initialize(quest : BaseQuest) -> void:
	quest_title.text = quest.quest_title
	quest_description.text = quest.quest_description
	selected_quest = quest
	
	clear_quest_slots()
	
	match quest.quest_size:
		BaseQuest.QUEST_SIZE.SMALL:
			questslots_node.set_small_quest_slot()
		BaseQuest.QUEST_SIZE.MEDIUM:
			questslots_node.set_medium_quest_slot()
	
	renown_label_amount.text = String(quest.quest_reward_renown)
	quest_percentage.set_quest_chance(quest.quest_base_success)


func _on_QuestSlots_clicked_on_icon(index):
	emit_signal("clicked_on_char_icon",index)


func clear_quest_slots() -> void:
	questslots_node.clear_char_icons()


func clear_index_quest_slot(index : int) -> void:
	questslots_node.clear_index_slot_icon(index)


func can_add_character_to_quest() -> bool :
	return questslots_node.has_free_slots()


func add_char_to_quest(character : CharacterInfo) -> int:
	if can_add_character_to_quest():
		var index  = questslots_node.add_character(character)
		if index == -1:
			print("ERROR: QuestInfo add_char_to_quest, index resulted -1")
		return index
	return -1


func has_valid_quest() -> bool:
	return selected_quest != null

func _on_Button_pressed() -> void:
	emit_signal("pressed_contract_button")

func show_error_popup() -> void:
	error_pop_up.Initialize()
	(error_pop_up as Popup).popup()


func set_character_availabe(character : CharacterInfo) -> void:
	questslots_node.set_character_available(character)


func set_character_unavailabe(character : CharacterInfo) -> void:
	questslots_node.set_character_unavailable(character)