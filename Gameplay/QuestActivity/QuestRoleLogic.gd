extends Node

class_name QuestRoleLogic
"""
	Calculates base extra quest chance for team compositions, aka the holy trinity setup:
	Healer - Tank - DPS
	
	Expected input:
		teamData[CharacterInfo.CLASS_ROLE...]
		
	Expected output:
		
"""

func process_team(teamData : Dictionary) -> Dictionary:
	if (teamData["Quest"] as BaseQuest).quest_size == BaseQuest.QUEST_SIZE.SMALL:
		return process_as_small_team(teamData)
	elif (teamData["Quest"] as BaseQuest).quest_size == BaseQuest.QUEST_SIZE.MEDIUM:
		return process_as_medium_team(teamData)
	return {}


func process_as_small_team(teamData : Dictionary) -> Dictionary:
	var result := {}
	result["Chance"] = 0
	
	if has_trinity(teamData):
		result["Chance"] += 25
		
	var start_chance := 3
	for i in range(0,teamData[CharacterInfo.CLASS_ROLE.DPS]):
		result["Chance"] += 3 - i
	for i in range(0,teamData[CharacterInfo.CLASS_ROLE.TANK]):
		result["Chance"] += 3 - i
	for i in range(0,teamData[CharacterInfo.CLASS_ROLE.HEALER]):
		result["Chance"] += 3 - i
	
	return result


func has_trinity(teamData : Dictionary) -> bool:
	if teamData[CharacterInfo.CLASS_ROLE.DPS] != 0 and teamData[CharacterInfo.CLASS_ROLE.HEALER] != 0 and teamData[CharacterInfo.CLASS_ROLE.TANK] != 0:
		return true
	return false
	

func process_as_medium_team(teamData : Dictionary) -> Dictionary:
	var result := {}
	result["Chance"] = 0
	
	if has_trinity(teamData):
		result["Chance"] += 15
	if has_double_trinity(teamData):
		result["Chance"] += 15
	if has_triple_trinity(teamData):
		result["Chance"] += 15
	
	var start_chance := 1
	for i in range(0,teamData[CharacterInfo.CLASS_ROLE.DPS]):
		result["Chance"] += start_chance
	for i in range(0,teamData[CharacterInfo.CLASS_ROLE.TANK]):
		result["Chance"] += start_chance
	for i in range(0,teamData[CharacterInfo.CLASS_ROLE.HEALER]):
		result["Chance"] += start_chance
	
	return result


func has_double_trinity(teamData : Dictionary) -> bool:
	if teamData[CharacterInfo.CLASS_ROLE.DPS] >= 2 and teamData[CharacterInfo.CLASS_ROLE.HEALER] >= 2 and teamData[CharacterInfo.CLASS_ROLE.TANK] >= 2:
		return true
	return false


func has_triple_trinity(teamData : Dictionary) -> bool:
	if teamData[CharacterInfo.CLASS_ROLE.DPS] >= 3 and teamData[CharacterInfo.CLASS_ROLE.HEALER] >= 3 and teamData[CharacterInfo.CLASS_ROLE.TANK] >= 3:
		return true
	return false