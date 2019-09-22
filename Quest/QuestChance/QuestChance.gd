extends TextureProgress

onready var percentage_label = $PercentageLabel

export var low_chance_color : Color
export var high_chance_color : Color

export var update_speed := 0.2

var time_passed := 0.0
var target_quest_chance := 0
var current_quest_chance := 0

var update_quest_chance := false


func set_quest_chance(chance : int) -> void:
	target_quest_chance = chance
	update_quest_chance = true


func _process(delta):
	if update_quest_chance:
		if target_quest_chance == current_quest_chance:
			update_quest_chance = false
	
	if update_quest_chance:
		time_passed += delta
		if time_passed >= update_speed:
			time_passed = 0.0
			if target_quest_chance > current_quest_chance:
				current_quest_chance += 1
			else:
				current_quest_chance -= 1
			update_progress_label()


func test_run() -> void:
	set_quest_chance(int(rand_range(0,100)))


func update_progress_label() -> void:
	percentage_label.text = String(current_quest_chance) + "%"
	var t : float = -(-100 + value) /100
	tint_progress = high_chance_color * (1 - t) + low_chance_color * t
	value = current_quest_chance