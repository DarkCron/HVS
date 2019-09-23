extends Node

var female_first_names_file = "res://Content/NameLists/firstnames_female.txt"
var male_first_names_file = "res://Content/NameLists/firstnames_male.txt"
var last_names_file = "res://Content/NameLists/lastnames.txt"

var female_first_names : Array = []
var male_first_names : Array = []
var last_names : Array = []

func _process_names() -> void:
	var file : File = File.new()
	file.open(female_first_names_file,File.READ)
	file.get_line()
	file.get_line()
	file.get_line()
	file.get_line()
	while not file.eof_reached():
		var name = file.get_line()
		female_first_names.append(name)
	file.close()
	
	file.open(male_first_names_file,File.READ)
	file.get_line()
	file.get_line()
	file.get_line()
	file.get_line()
	while not file.eof_reached():
		var name = file.get_line()
		male_first_names.append(name)
	file.close()
	
	file.open(last_names_file,File.READ)
	file.get_line()
	file.get_line()
	file.get_line()
	file.get_line()
	while not file.eof_reached():
		var name = file.get_line()
		last_names.append(name)
	file.close()

func get_random_first_name(isMale) -> String:
	if female_first_names.size() == 0 or male_first_names.size() == 0 or last_names.size() == 0:
		_process_names()
	
	randomize()
	if isMale:
		return male_first_names[randi() % male_first_names.size()]
	else:
		return female_first_names[randi() % female_first_names.size()]
	
	return "BABA YAGA"


func get_random_last_name() -> String:
	if female_first_names.size() == 0 or male_first_names.size() == 0 or last_names.size() == 0:
		_process_names()
	
	randomize()
	return last_names[randi() % last_names.size()]