extends Control

onready var questslots_node = $QuestSlots
onready var quest_description = $PanelContainer/RichTextLabel
onready var quest_title = $Label

func _ready():
	questslots_node.set_small_quest_slot()
	quest_description.text = ""
	quest_title.text = ""


func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and false:
		var temp = $QuestSlots
		if int(rand_range(0,2)) == 0 :
			temp.set_small_quest_slot()
		else:
			temp.set_medium_quest_slot()


func Initialize(quest : BaseQuest) -> void:
	quest_title.text = quest.quest_title
	quest_description.text = quest.quest_description
	
	match quest.QUEST_SIZE:
		BaseQuest.QUEST_SIZE.SMALL:
			questslots_node.set_small_quest_slot()
		BaseQuest.QUEST_SIZE.MEDIUM:
			questslots_node.set_medium_quest_slot()
			
	pass