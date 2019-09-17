extends Node

static func _process_level(var level):
	var result = {'TownLevel': (level / 4) + 1,'Gold': (level-1) * 1.25 * 1000}
	result['NormalItem'] = 1 + level / 2; 
	result['UncommonItem'] = level / 3; 
	result['RareItem'] = level / 4;
	result['EpicItem'] = 0;
		
	result['NormalItemArmour'] = 1 + level / 2; 
	result['UncommonItemArmour'] = level / 3; 
	result['RareItemArmour'] = level / 4;
	result['EpicItemArmour'] = 0;
	
	return result	

static func get_building_level_info(var currentLevel, var newLevel):
	var result = null
	
	if currentLevel == newLevel:
		result = _process_level(currentLevel)
		result['Gold'] = 0
	else:
		for i in range(currentLevel+1,newLevel+1):
			if result == null:
				result = _process_level(i)
			else:
				var temp = _process_level(i)
				temp['Gold'] += result['Gold']
				result = temp
	
	return result


static func generate_extras() -> Dictionary:
	var result : Dictionary = {'TownLevel': 0,'Gold': 0}
	
	result['NormalItem'] = 0; 
	result['UncommonItem'] = 0; 
	result['RareItem'] = 0;
	result['EpicItem'] = 0;
		
	result['NormalItemArmour'] = 0; 
	result['UncommonItemArmour'] = 0; 
	result['RareItemArmour'] = 0;
	result['EpicItemArmour'] = 0;
	
	return result