class_name CharacterInfo

enum CLASS_ROLE { DPS, HEALER, TANK }
enum GENDER { MALE, FEMALE }
var level_to_value : Dictionary = {
	1 : 250,
	2 : 500,
	3 : 800,
	4 : 1300,
	5 : 2000
}
var extra_value_to_chance : Dictionary = {
	300 : 1,
	800 : 2,
	1500 : 3,
	2000 : 4,
	2500 : 5
}

var character_role : int = CLASS_ROLE.DPS
var character_gender = GENDER.MALE

var character_surname : String = "Jon" setget set_character_surname, get_character_surname
var character_familyname : String = "Nieve and a bit more" setget set_character_familyname, get_character_familyname
var character_nickname : String = "Wolf" setget set_character_nickname, get_character_nickname

var character_level : int = 1 setget ,get_character_level
var character_total_exp : int setget ,get_character_totalEXP

var character_icon_set : int = 1
var character_icon_frame : int = 1

var character_currently_on_quest : bool = false

var character_value_to_accept = level_to_value[1]


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


func does_character_accept_value(amount : int) -> bool:
	if character_level > 5:
		return amount >= level_to_value[5]
	else:
		return amount >= level_to_value[character_level]
	return false


static func generate_random_char(random_char : CharacterInfo) -> CharacterInfo :
	random_char.character_icon_set = int(rand_range(0,4))
	random_char.character_icon_frame = int(rand_range(0,16))
	random_char.character_role = generate_random_role()
	random_char.character_gender = generate_random_gender()
	random_char.character_surname = NameGen.get_random_first_name(random_char.character_gender == GENDER.MALE)
	random_char.character_familyname = NameGen.get_random_last_name()
	
	return random_char


static func generate_random_role():
	randomize()
	randomize()
	var rand = randi() % 3
	match rand:
		0:
			return CLASS_ROLE.DPS
		1:
			return CLASS_ROLE.TANK
		2:
			return CLASS_ROLE.HEALER


static func generate_random_gender():
	randomize()
	randomize()
	var rand = randi() % 2
	match rand:
		0:
			return GENDER.MALE
		1:
			return GENDER.FEMALE

