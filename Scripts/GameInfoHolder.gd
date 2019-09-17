extends Node

var currentGold : int = 5000 setget set_current_gold, get_current_gold

func set_current_gold(value : int):
	currentGold = value


func get_current_gold() -> int:
	return currentGold
