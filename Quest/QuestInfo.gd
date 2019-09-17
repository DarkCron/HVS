extends Control

func _ready():
	var temp = $QuestSlots
	if rand_range(0,2) == 0 :
		temp.set_small_quest_slot()
	else:
		temp.set_medium_quest_slot()


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var temp = $QuestSlots
		if int(rand_range(0,2)) == 0 :
			temp.set_small_quest_slot()
		else:
			temp.set_medium_quest_slot()