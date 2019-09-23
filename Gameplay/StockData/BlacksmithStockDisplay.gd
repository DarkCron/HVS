extends Control

onready var labels : Dictionary = {
	BaseItem.WEAPON_QUALITY.NORMAL : $WeaponContainer/Normal/Label,
	BaseItem.WEAPON_QUALITY.UNCOMMON : $WeaponContainer/Uncommon/Label,
	BaseItem.WEAPON_QUALITY.RARE : $WeaponContainer/Rare/Label,
	BaseItem.WEAPON_QUALITY.EPIC : $WeaponContainer/Epic/Label,
	
	BaseItem.ARMOUR_QUALITY.NORMAL : $ArmourContainer/Normal/Label,
	BaseItem.ARMOUR_QUALITY.UNCOMMON : $ArmourContainer/Uncommon/Label,
	BaseItem.ARMOUR_QUALITY.RARE : $ArmourContainer/Rare/Label,
	BaseItem.ARMOUR_QUALITY.EPIC : $ArmourContainer/Epic/Label,
}


func update_labels() -> void:
	for item in BaseItem.WEAPON_QUALITY:
		(labels[BaseItem.WEAPON_QUALITY[item]] as Label).text = String(StockData.current_stock_data[BaseItem.WEAPON_QUALITY[item]])
		
		
	for item in BaseItem.ARMOUR_QUALITY:
		(labels[BaseItem.ARMOUR_QUALITY[item]] as Label).text = String(StockData.current_stock_data[BaseItem.ARMOUR_QUALITY[item]])
		