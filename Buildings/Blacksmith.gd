extends Control

onready var CurrentNormal = $LowerProduceBox/Produce/NormalAmount
onready var CurrentUncommon = $LowerProduceBox/Produce/UncommonAmount
onready var CurrentRare = $LowerProduceBox/Produce/RareAmount
onready var CurrentEpic = $LowerProduceBox/Produce/EpicAmount

onready var CurrentNormalArmour = $LowerProduceBox/Produce/NormalAmount2
onready var CurrentUncommonArmour = $LowerProduceBox/Produce/UncommonAmount2
onready var CurrentRareArmour = $LowerProduceBox/Produce/RareAmount2
onready var CurrentEpicArmour = $LowerProduceBox/Produce/EpicAmount2

onready var NewNormal = $LowerProduceBox/ProduceNew/NormalAmount
onready var NewUncommon = $LowerProduceBox/ProduceNew/UncommonAmount
onready var NewRare = $LowerProduceBox/ProduceNew/RareAmount
onready var NewEpic = $LowerProduceBox/ProduceNew/EpicAmount

onready var NewNormalArmour = $LowerProduceBox/ProduceNew/NormalAmount2
onready var NewUncommonArmour = $LowerProduceBox/ProduceNew/UncommonAmount2
onready var NewRareArmour = $LowerProduceBox/ProduceNew/RareAmount2
onready var NewEpicArmour = $LowerProduceBox/ProduceNew/EpicAmount2

onready var TitleCurrentLevelLabel = $HeaderBox/LevelAmount
onready var NewLevelAmountLabel = $Control/LevelControl/NewLevelAmount
onready var GoldReqAmountLabel = $Control/GoldReqAmount
onready var TownLevelReqAmountLabel = $Control/TownLevelReqAmount

onready var DecreaseLevelButton = $Control/LevelControl/DecreaseLevelButton
onready var IncreaseLevelButton = $Control/LevelControl/IncreaseLevelButton
onready var LevelUpButton = $Control/LevelUpButton

var currentLevel : int = 1
var newLevel : int = 1
var goldRequiredToLevelUp : int = 0

func _ready():
	Reset()


func Reset() -> void:
	DecreaseLevelButton.disabled = true
	IncreaseLevelButton.disabled = false
	LevelUpButton.disabled = true
	goldRequiredToLevelUp = 0
	GoldReqAmountLabel.text = String(0)
	pass

func _on_DecreaseLevelButton_pressed():
	newLevel -= 1
	_process_increase_decrease_button()
	pass # Replace with function body.


func _on_IncreaseLevelButton_pressed():
	newLevel += 1
	_process_increase_decrease_button()
	pass # Replace with function body.


func _on_LevelUpButton_pressed():
	_process_level_up()
	pass # Replace with function body.

func _process_level_up() -> void:
	currentLevel = newLevel
	
	Blacksmith_data.process_levelUp(BuildingLevelInfo_Blacksmith.get_building_level_info(currentLevel,currentLevel))
	_process_blacksmith_data(Blacksmith_data.get_bs_benefits_level())
	Reset()
	pass
	
func _process_increase_decrease_button():
	
	if newLevel > currentLevel:
		DecreaseLevelButton.disabled = false
	elif newLevel == currentLevel:
		DecreaseLevelButton.disabled = true
		LevelUpButton.disabled = true
	
	if newLevel >= currentLevel + 5:
		IncreaseLevelButton.disabled = true
	else:
		IncreaseLevelButton.disabled = false
	
	var result = BuildingLevelInfo_Blacksmith.get_building_level_info(currentLevel,newLevel)
	_process_info(result);
	
	if newLevel > currentLevel and not IncreaseLevelButton.disabled:
		if GameInfoHolder.get_current_gold() >= goldRequiredToLevelUp:
			LevelUpButton.disabled = false
		else:
			LevelUpButton.disabled = true
	
	pass
	
func _process_info(info):
	var extras : Dictionary = Blacksmith_data.get_bs_extras()
	
	var Gold = info['Gold']
	var TownLevel = info['TownLevel']
	
	var normals = info['NormalItem'] + extras['NormalItem']
	var uncommons = info['UncommonItem'] + extras['UncommonItem']
	var rares = info['RareItem'] + extras['RareItem']
	var epics = info['EpicItem'] + extras['EpicItem']
	
	var normalsArmour = info['NormalItemArmour'] + extras['NormalItemArmour']
	var uncommonsArmour = info['UncommonItemArmour'] + extras['UncommonItemArmour']
	var raresArmour = info['RareItemArmour'] + extras['RareItemArmour']
	var epicsArmour = info['EpicItemArmour'] + extras['EpicItemArmour']
	
	GoldReqAmountLabel.text = String(Gold)
	TownLevelReqAmountLabel.text = String(TownLevel)
	
	NewNormal.text = String(normals) 
	NewUncommon.text = String(uncommons)
	NewRare.text = String(rares)
	NewEpic.text = String(epics)
	
	NewNormalArmour.text = String(normalsArmour) 
	NewUncommonArmour.text = String(uncommonsArmour)
	NewRareArmour.text = String(raresArmour)
	NewEpicArmour.text = String(epicsArmour)
	
	NewLevelAmountLabel.text = String(newLevel)
	
	goldRequiredToLevelUp = Gold
	pass


func _process_blacksmith_data(info:Dictionary):
	var extras : Dictionary = Blacksmith_data.get_bs_extras()
		
	var normals = info['NormalItem'] + extras['NormalItem']
	var uncommons = info['UncommonItem'] + extras['UncommonItem']
	var rares = info['RareItem'] + extras['RareItem']
	var epics = info['EpicItem'] + extras['EpicItem']
	
	var normalsArmour = info['NormalItemArmour'] + extras['NormalItemArmour']
	var uncommonsArmour = info['UncommonItemArmour'] + extras['UncommonItemArmour']
	var raresArmour = info['RareItemArmour'] + extras['RareItemArmour']
	var epicsArmour = info['EpicItemArmour'] + extras['EpicItemArmour']
	
	CurrentNormal.text = String(normals) 
	CurrentUncommon.text = String(uncommons)
	CurrentRare.text = String(rares)
	CurrentEpic.text = String(epics)
	
	CurrentNormalArmour.text = String(normalsArmour) 
	CurrentUncommonArmour.text = String(uncommonsArmour)
	CurrentRareArmour.text = String(raresArmour)
	CurrentEpicArmour.text = String(epicsArmour)
	
	TitleCurrentLevelLabel.text = String(newLevel)
	pass
