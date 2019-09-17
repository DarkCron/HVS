extends Node

var alchemistLevel : int = 1
var blacksmithLevel : int = 1

func process_alchemist_data() -> void:
	alchemistLevel = Alchemist_data.get_alch_level()
	pass