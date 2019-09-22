class_name BaseQuest

enum QUEST_TYPE { EXPLORATION, GATHER, EXTERMINATION }
enum QUEST_SIZE { SMALL, MEDIUM }

var quest_name : String = "Quest Name"
var quest_id : int = -1
var quest_title : String = "Quest Title"
var quest_description : String = "Quest Description"

var quest_base_success : int = 50
var quest_base_duration : int = 3
var quest_level : int = 1

var quest_type = QUEST_TYPE.EXPLORATION
var quest_size = QUEST_SIZE.SMALL

var quest_reward_renown = 100

static func test_random_quest(quest : BaseQuest) -> BaseQuest:
	if randi() % 2 == 0:
		quest.quest_size = QUEST_SIZE.SMALL
	else:
		quest.quest_size = QUEST_SIZE.MEDIUM
	
	var random = randi() % 3
	if random == 0:
		quest.quest_type = QUEST_TYPE.EXPLORATION
	elif random == 1:
		quest.quest_type = QUEST_TYPE.GATHER
	elif random == 2:
		quest.quest_type = QUEST_TYPE.EXTERMINATION
	
	return quest