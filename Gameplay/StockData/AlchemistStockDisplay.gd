extends Control

onready var labels : Dictionary = {
	BaseItem.POTION_QUALITY.NORMAL : $Stock/Normal/Label,
	BaseItem.POTION_QUALITY.UNCOMMON : $Stock/Uncommon/Label,
	BaseItem.POTION_QUALITY.RARE : $Stock/Rare/Label,
	BaseItem.POTION_QUALITY.EPIC : $Stock/Epic/Label,
}


func update_labels() -> void:
	for item in BaseItem.POTION_QUALITY:
		(labels[BaseItem.POTION_QUALITY[item]] as Label).text = String(StockData.current_stock_data[BaseItem.POTION_QUALITY[item]])
		