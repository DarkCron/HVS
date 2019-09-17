class_name BaseQuest

enum QUEST_TYPE { EXPLORATION, GATHER, EXTERMINATION }

var quest_name : String = "Quest Name"
var quest_id : int = -1
var quest_title : String = "Quest Title"
var quest_description : String = "Quest Description"

var quest_base_success : int = 50
var quest_base_duration : int = 3
var quest_level : int = 1

var quest_type = QUEST_TYPE.EXPLORATION