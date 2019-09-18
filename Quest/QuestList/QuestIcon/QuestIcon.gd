extends Control

onready var quest_icon : AnimatedSprite = $QuestIconSet

func Initialize(quest : BaseQuest) -> void:
	
	match quest.quest_type:
		BaseQuest.QUEST_TYPE.EXPLORATION:
			quest_icon.frame = 0
		BaseQuest.QUEST_TYPE.GATHER:
			quest_icon.frame = 2
		BaseQuest.QUEST_TYPE.EXTERMINATION:
			quest_icon.frame = 3