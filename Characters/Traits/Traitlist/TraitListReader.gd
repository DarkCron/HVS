extends Node

var traitlist : Dictionary = {}

func ProcessTraitList():
	var result := {}
	var file : File = File.new()
	file.open("res://Characters/Traits/Traitlist/traitlist.tres",File.READ)
	while not file.eof_reached():
		var name = file.get_line()
		var description = file.get_line()
		var id = file.get_line()
		
		var trait : BaseTrait = BaseTrait.new()
		trait.Initialize(name,description)
		trait.set_id(int(id))
		
		var line = file.get_line()
		
		if line.nocasecmp_to("---") == 0:
			continue
		
		if line.nocasecmp_to("*") == 0:
			line = file.get_line()
			while line.nocasecmp_to("#") != 0 and line.nocasecmp_to("---") != 0 :
				var effect_name = line
				var effect_value = file.get_line()
				trait.add_trait_value(effect_name,effect_value)
				
				line = file.get_line()
		
		if line.nocasecmp_to("#") == 0:
			line = file.get_line()
			var other_name = line
			trait.add_alternate_trait(other_name)
			line = file.get_line()
			while line.nocasecmp_to("---") != 0:
				var effect_name = line
				var effect_value = file.get_line()
				trait.add_alternate_trait_value(other_name, effect_name,effect_value)
				
				line = file.get_line()
		
		traitlist[id] = trait