extends Node

var alchemistLevel : int = 1 setget set_alch_level , get_alch_level #DO SAVE
var currentLevelBenefits : Dictionary  setget set_alch_benefits_level , get_alch_benefits_level# Dictionary definitions at end of file, DO NOT SAVE
var additionalBenefits : Dictionary #DO SAVE


signal alchemist_level_changed

func _ready():
	currentLevelBenefits = BuildingLevelInfo_Alchemist.get_building_level_info(alchemistLevel,alchemistLevel)
	additionalBenefits = BuildingLevelInfo_Alchemist.generate_extras()

func set_alch_level(value : int) -> void:
	alchemistLevel = value


func get_alch_level() -> int:
	return alchemistLevel


func set_alch_benefits_level(value : Dictionary) -> void:
	currentLevelBenefits = value

"""
Returns the FULL COMPLETE benefits of current alchemist level + acquired bonuses.
"""
func get_alch_benefits_level() -> Dictionary:
	return _get_result_benefits(currentLevelBenefits,additionalBenefits)


func get_alch_extras() -> Dictionary:
	return additionalBenefits


func _get_result_benefits(current : Dictionary, extra : Dictionary) -> Dictionary:
	if extra.size() == 0:
		extra = BuildingLevelInfo_Alchemist.generate_extras()
	
	var result : Dictionary = {'TownLevel': current['TownLevel'],
	'Gold': current['TownLevel'],
	'NormalItem': current['NormalItem'] + extra['NormalItem'],
	'UncommonItem':current['UncommonItem'] + extra['UncommonItem'],
	'RareItem':current['RareItem'] + extra['RareItem'],
	'EpicItem':current['EpicItem'] + extra['EpicItem'],
	'SpeedMod':current['SpeedMod'] + extra['SpeedMod'],
	'EXPMod':current['EXPMod'] + extra['EXPMod'],
	'QuestMod':current['QuestMod'] + extra['QuestMod']}
	
	return result


func process_levelUp(value:Dictionary):
	currentLevelBenefits = value
	pass
	
	
"""
	var result = {'TownLevel': (level / 3) + 1,'Gold': (level-1) * 1.5 * 1000}
	result['NormalItem'] = 1 + level / 2; 
	result['UncommonItem'] = level / 3; 
	result['RareItem'] = level / 4;
	result['EpicItem'] = 0;
		
	result['SpeedMod'] = level-1; 
	result['EXPMod'] = level/2; 
	result['QuestMod'] = level/4;
"""