class_name BaseTrait

var name := "Trait"
var description := "Example text."
var id := -1

var trait_values : Dictionary = {}
var alternate_trait_values : Dictionary = {}

func _init():
	#Chance, EXP, Speed, Cost, Motivation, Item
	trait_values["CHANCE"] = 0
	trait_values["EXP"] = 0
	trait_values["SPEED"] = 0
	trait_values["COST"] = 0
	trait_values["MOTIVATION"] = 0
	trait_values["ITEM"] = 0


func add_trait_value(name : String, value : String):
	for item in trait_values.keys():
		if (item as String).nocasecmp_to(name) == 0:
			trait_values[item] = float(value)
			print("Effect: " +name+", "+value)
			break


func add_alternate_trait(name : String):
	alternate_trait_values[name] = {}
	alternate_trait_values[name]["CHANCE"] = 0
	alternate_trait_values[name]["EXP"] = 0
	alternate_trait_values[name]["SPEED"] = 0
	alternate_trait_values[name]["COST"] = 0
	alternate_trait_values[name]["MOTIVATION"] = 0
	alternate_trait_values[name]["ITEM"] = 0


func add_alternate_trait_value(alternate_name : String, name : String, value : String):
	for item in alternate_trait_values[alternate_name].keys():
		if (item as String).nocasecmp_to(name) == 0:
			trait_values[item] = float(value)
			print("Effect: " +name+", "+value)
			break


func Initialize(name: String, description: String) -> void:
	self.name = name
	self.description = description
	#print("Trait: " +name+", "+description)


func set_id(id) -> void:
	self.id = id

func do_something() -> void:
	pass