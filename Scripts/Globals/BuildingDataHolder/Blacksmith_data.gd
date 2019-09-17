extends Node

var blacksmithLevel : int = 1 setget set_bs_level , get_bs_level #DO SAVE
var currentLevelBenefits : Dictionary  setget set_bs_benefits_level , get_bs_benefits_level# Dictionary definitions at end of file, DO NOT SAVE
var additionalBenefits : Dictionary #DO SAVE


signal blacksmith_level_changed

func _ready():
	currentLevelBenefits = BuildingLevelInfo_Blacksmith.get_building_level_info(blacksmithLevel,blacksmithLevel)
	additionalBenefits = BuildingLevelInfo_Blacksmith.generate_extras()

func set_bs_level(value : int) -> void:
	blacksmithLevel = value


func get_bs_level() -> int:
	return blacksmithLevel


func set_bs_benefits_level(value : Dictionary) -> void:
	currentLevelBenefits = value

"""
Returns the FULL COMPLETE benefits of current blacksmith level + acquired bonuses.
"""
func get_bs_benefits_level() -> Dictionary:
	return _get_result_benefits(currentLevelBenefits,additionalBenefits)


func get_bs_extras() -> Dictionary:
	return additionalBenefits


func _get_result_benefits(current : Dictionary, extra : Dictionary) -> Dictionary:
	if extra.size() == 0:
		extra = BuildingLevelInfo_Blacksmith.generate_extras()
	
	var result : Dictionary = {'TownLevel': current['TownLevel'],
	'Gold': current['TownLevel'],
	'NormalItem': current['NormalItem'] + extra['NormalItem'],
	'UncommonItem':current['UncommonItem'] + extra['UncommonItem'],
	'RareItem':current['RareItem'] + extra['RareItem'],
	'EpicItem':current['EpicItem'] + extra['EpicItem'],
	
	'NormalItemArmour': current['NormalItemArmour'] + extra['NormalItemArmour'],
	'UncommonItemArmour':current['UncommonItemArmour'] + extra['UncommonItemArmour'],
	'RareItemArmour':current['RareItemArmour'] + extra['RareItemArmour'],
	'EpicItemArmour':current['EpicItemArmour'] + extra['EpicItemArmour'] }

	
	return result


func process_levelUp(value:Dictionary):
	currentLevelBenefits = value
	pass
	
	
"""
	var result = {'TownLevel': (level / 4) + 1,'Gold': (level-1) * 1.25 * 1000}
	result['NormalItem'] = 1 + level / 2; 
	result['UncommonItem'] = level / 3; 
	result['RareItem'] = level / 4;
	result['EpicItem'] = 0;
		
	result['NormalItemArmour'] = 1 + level / 2; 
	result['UncommonItemArmour'] = level / 3; 
	result['RareItemArmour'] = level / 4;
	result['EpicItemArmour'] = 0;
"""