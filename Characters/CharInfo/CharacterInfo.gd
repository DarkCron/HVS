class_name CharacterInfo

var character_surname : String = "Jon" setget set_character_surname, get_character_surname
var character_familyname : String = "Nieve and a bit more" setget set_character_familyname, get_character_familyname
var character_nickname : String = "Wolf" setget set_character_nickname, get_character_nickname

var character_level : int = 1 setget ,get_character_level
var character_total_exp : int setget ,get_character_totalEXP

var character_icon_set : int = 1
var character_icon_frame : int = 1

func get_character_name() -> String:
	return character_surname + " \"" + character_nickname + "\" " + character_familyname


func set_character_surname(value: String) -> void:
	character_surname = value


func get_character_surname() -> String:
	return character_surname


func set_character_familyname(value: String) -> void:
	character_familyname = value


func set_character_nickname(value: String) -> void:
	character_nickname = value


func get_character_nickname() -> String:
	return character_nickname


func get_character_familyname() -> String:
	return character_familyname


func get_character_level() -> int:
	return character_level


func get_character_totalEXP() -> int:
	return character_total_exp