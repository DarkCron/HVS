extends Control

onready var NewLevelLabel = get_node("Control/LevelControl/NewLevelAmount")
onready var DecreaseLevelButton = get_node("Control/LevelControl/DecreaseLevelButton")
onready var IncreaseLevelButton = get_node("Control/LevelControl/IncreaseLevelButton")

onready var GoldAmountLabel =  get_node("Control/GoldReqAmount")
onready var TownLevelLabel = get_node("Control/TownLevelReqAmount")

onready var NewSpeedLabel = get_node("LowerProduceBox/ProduceNew/SpeedModAmount")
onready var NewEXPLabel = get_node("LowerProduceBox/ProduceNew/EXPModAmount")
onready var NewSuccessLabel = get_node("LowerProduceBox/ProduceNew/SuccessModAmount")

onready var SpeedLabel = get_node("LowerProduceBox/Produce/SpeedModAmount")
onready var EXPLabel = get_node("LowerProduceBox/Produce/EXPModAmount")
onready var SuccessLabel = get_node("LowerProduceBox/Produce/SuccessModAmount")

onready var NewNormalLabel = get_node("LowerProduceBox/ProduceNew/NormalAmount")
onready var NewUncLabel = get_node("LowerProduceBox/ProduceNew/UncommonAmount")
onready var NewRareLabel = get_node("LowerProduceBox/ProduceNew/RareAmount")
onready var NewEpicLabel = get_node("LowerProduceBox/ProduceNew/EpicAmount")

onready var NormalLabel = get_node("LowerProduceBox/Produce/NormalAmount")
onready var UncLabel = get_node("LowerProduceBox/Produce/UncommonAmount")
onready var RareLabel = get_node("LowerProduceBox/Produce/RareAmount")
onready var EpicLabel = get_node("LowerProduceBox/Produce/EpicAmount")

onready var LegendPanel = $LowerProduceBox/LegendPanel
onready var LegendCheckBox = $LowerProduceBox/CheckBox

onready var CurrentLevelAmountLabel = $HeaderBox/LevelAmount
onready var LevelUpButton = $Control/LevelUpButton

var currentLevel = 1
var newLevel = 1
var goldRequiredToLevelUp = 0

func _ready():
	currentLevel = Alchemist_data.get_alch_level()
	newLevel = currentLevel
	var currentLevelInfo = Alchemist_data.get_alch_benefits_level()
	_process_alchemist_data(currentLevelInfo)
	
	Reset()
	


func Reset() -> void:
	DecreaseLevelButton.disabled = true
	IncreaseLevelButton.disabled = false
	LevelUpButton.disabled = true
	goldRequiredToLevelUp = 0
	GoldAmountLabel.text = String(0)
	pass


func _on_DecreaseLevelButton_pressed() -> void:
	newLevel -= 1
	
	_process_increase_decrease_button()
	
	pass


func _on_IncreaseLevelButton_pressed() -> void:
	newLevel += 1
	
	_process_increase_decrease_button()
	
	pass # Replace with function body.


func _on_LevelUpButton_pressed()  -> void:
	_process_level_up()
	pass # Replace with function body.


func _process_level_up() -> void:
	currentLevel = newLevel
	
	Alchemist_data.process_levelUp(BuildingLevelInfo_Alchemist.get_building_level_info(currentLevel,currentLevel))
	_process_alchemist_data(Alchemist_data.get_alch_benefits_level())
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
	
	var result = BuildingLevelInfo_Alchemist.get_building_level_info(currentLevel,newLevel)
	_process_info(result);
	
	if newLevel > currentLevel and not IncreaseLevelButton.disabled:
		if GameInfoHolder.get_current_gold() >= goldRequiredToLevelUp:
			LevelUpButton.disabled = false
		else:
			LevelUpButton.disabled = true
	
	pass
	
func _process_info(info):
	var extras : Dictionary = Alchemist_data.get_alch_extras()
	
	var Gold = info['Gold']
	var TownLevel = info['TownLevel']
	
	var normals = info['NormalItem'] + extras['NormalItem']
	var uncommons = info['UncommonItem'] + extras['UncommonItem']
	var rares = info['RareItem'] + extras['RareItem']
	var epics = info['EpicItem'] + extras['EpicItem']
	
	var speed = info['SpeedMod'] + extras['SpeedMod']
	var EXP = info['EXPMod'] + extras['EXPMod'] 
	var quest = info['QuestMod'] + extras['QuestMod']
	
	GoldAmountLabel.text = String(Gold)
	TownLevelLabel.text = String(TownLevel)
	
	NewNormalLabel.text = String(normals) 
	NewUncLabel.text = String(uncommons)
	NewRareLabel.text = String(rares)
	NewEpicLabel.text = String(epics)
	
	NewSpeedLabel.text = String(speed) + '%'
	NewEXPLabel.text = String(EXP) + '%'
	NewSuccessLabel.text = String(quest) + '%'
	
	NewLevelLabel.text = String(newLevel)
	
	goldRequiredToLevelUp = Gold
	pass


func _process_alchemist_data(info:Dictionary):
	var normals = info['NormalItem']
	var uncommons = info['UncommonItem']
	var rares = info['RareItem']
	var epics = info['EpicItem']
	
	var speed = info['SpeedMod']
	var EXP = info['EXPMod'] 
	var quest = info['QuestMod'] 
	
	NormalLabel.text = String(normals)
	UncLabel.text = String(uncommons)
	RareLabel.text = String(rares)
	EpicLabel.text = String(epics)
	
	SpeedLabel.text = String(speed) + '%'
	EXPLabel.text = String(EXP) + '%'
	SuccessLabel.text = String(quest) + '%'
	
	NewLevelLabel.text = String(newLevel)
	
	CurrentLevelAmountLabel.text = String(currentLevel)
	pass


func _on_CheckBox_pressed() -> void:
	LegendPanel.visible = LegendCheckBox.pressed
