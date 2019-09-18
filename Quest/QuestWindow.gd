extends Control

onready var quest_info_node = $QuestInfo

func _on_QuestList_clicked_on_quest(quest : BaseQuest):
	quest_info_node.Initialize(quest)

