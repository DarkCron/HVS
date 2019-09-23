"""
Handles the logic between, a:
	CHARACTER: it's traits
	QUEST: level compatibility and success calculation
	REWARDS: value of quest per character
	
Check order should be: CHARACTER + REWARDS -> QUEST
"""

"""
Input:
	["characters"] = [...] 
	["gold"] = 500 -> per player
	["weapon"] 
	["Potion"]
	["Armour"]
Result:
	[char_info] = true/false -> agrees to mission or not
	["chance"] = 77.7 -> 
	["EXP"] = 12 -> extra exp percentage 
	["Gold"] = 
"""
func process_and_result(gamedata : Dictionary) -> Dictionary:
	return {}