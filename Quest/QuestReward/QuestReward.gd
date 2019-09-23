extends Control

onready var rewardPopUp : PopupDialog = $PartyRewardHintPopup
onready var penaltyPopUp : PopupDialog = $PenaltyHintPopup

onready var money_label : Label = $MoneyRewardAmount
onready var money_slider : HSlider = $HSlider

onready var amount_of_weapons_label = $ScrollContainer2/HBoxContainer/WeaponAmount
onready var amount_of_armour_label = $ScrollContainer2/HBoxContainer/ArmourAmount
onready var amount_of_gold_label = $ScrollContainer2/HBoxContainer/GoldAmount

onready var penalty_amount_label = $ScrollContainer3/HBoxContainer/GoldAmount2

onready var reward_icon_collection_weapons : Dictionary = {
	BaseItem.WEAPON_QUALITY.NORMAL : $ScrollContainer2/HBoxContainer/WeaponRewardNormal,
	BaseItem.WEAPON_QUALITY.UNCOMMON : $ScrollContainer2/HBoxContainer/WeaponRewardUncommin,
	BaseItem.WEAPON_QUALITY.RARE : $ScrollContainer2/HBoxContainer/WeaponRewardRare,
	BaseItem.WEAPON_QUALITY.EPIC : $ScrollContainer2/HBoxContainer/WeaponRewardEpic
}
onready var reward_icon_collection_armour : Dictionary = {
	BaseItem.ARMOUR_QUALITY.NORMAL : $ScrollContainer2/HBoxContainer/ArmourRewardNormal,
	BaseItem.ARMOUR_QUALITY.UNCOMMON : $ScrollContainer2/HBoxContainer/ArmourRewardUncommon,
	BaseItem.ARMOUR_QUALITY.RARE : $ScrollContainer2/HBoxContainer/ArmourRewardRare,
	BaseItem.ARMOUR_QUALITY.EPIC : $ScrollContainer2/HBoxContainer/ArmourRewardEpic
}

var weaponCheckBoxes : Array = []
var armourCheckBoxes : Array = []
var potionCheckBoxes : Array = []

var quest_rewards_selection_boxes : Dictionary = {}
var selected_rewards_weapons : Dictionary = {
	BaseItem.WEAPON_QUALITY.NORMAL : false,
	BaseItem.WEAPON_QUALITY.UNCOMMON : false,
	BaseItem.WEAPON_QUALITY.RARE : false,
	BaseItem.WEAPON_QUALITY.EPIC : false
}
var selected_rewards_armour : Dictionary = {
	BaseItem.ARMOUR_QUALITY.NORMAL : false,
	BaseItem.ARMOUR_QUALITY.UNCOMMON : false,
	BaseItem.ARMOUR_QUALITY.RARE : false,
	BaseItem.ARMOUR_QUALITY.EPIC : false
}
var selected_rewards_potion : Dictionary = {
	BaseItem.POTION_QUALITY.NORMAL : false,
	BaseItem.POTION_QUALITY.UNCOMMON : false,
	BaseItem.POTION_QUALITY.RARE : false,
	BaseItem.POTION_QUALITY.EPIC : false
}

onready var potion_selectionboxes : Dictionary = {
	BaseItem.POTION_QUALITY.NORMAL : $ScrollContainer/VBoxContainer/HBoxContainer/AlchemistNormal/CheckBox,
	BaseItem.POTION_QUALITY.UNCOMMON : $ScrollContainer/VBoxContainer/HBoxContainer/AlchemistUncommon/CheckBox,
	BaseItem.POTION_QUALITY.RARE : $ScrollContainer/VBoxContainer/HBoxContainer/AlchemistRare/CheckBox,
	BaseItem.POTION_QUALITY.EPIC : $ScrollContainer/VBoxContainer/HBoxContainer/AlchemistEpic/CheckBox
}

var bInPartyRewardHint := false
var bInPenaltyHint := false
var bStopTimer := false

var hintTimer := 1
var hintTimePassed := 0.0

var amount_of_players_to_reward := 0
var penalty_amount := 0

var reward_value := 0

signal quest_value_changed(amount)
signal selected_items_changed(item_type, item_info, is_selected)


func _ready():
	for item in $ScrollContainer/VBoxContainer/WeaponSelection.get_children():
		for child in item.get_children():
			if child is CheckBox:
				weaponCheckBoxes.append(child)
				child.connect("pressed", self, "_weaponcheckbox_handler",[child],0)
				child.pressed = false
				if item == $ScrollContainer/VBoxContainer/WeaponSelection/NormalWeapon:
					quest_rewards_selection_boxes[child] = BaseItem.WEAPON_QUALITY.NORMAL
				elif item == $ScrollContainer/VBoxContainer/WeaponSelection/UncommonWeapon:
					quest_rewards_selection_boxes[child] = BaseItem.WEAPON_QUALITY.UNCOMMON
				elif item == $ScrollContainer/VBoxContainer/WeaponSelection/RareWeapon:
					quest_rewards_selection_boxes[child] = BaseItem.WEAPON_QUALITY.RARE
				elif item == $ScrollContainer/VBoxContainer/WeaponSelection/EpicWeapon:
					quest_rewards_selection_boxes[child] = BaseItem.WEAPON_QUALITY.EPIC
	for item in $ScrollContainer/VBoxContainer/ArmourSelection.get_children():
		for child in item.get_children():
			if child is CheckBox:
				armourCheckBoxes.append(child)
				child.connect("pressed", self, "_armourcheckbox_handler",[child],0)
				child.pressed = false
				if item == $ScrollContainer/VBoxContainer/ArmourSelection/NormalArmour:
					quest_rewards_selection_boxes[child] = BaseItem.ARMOUR_QUALITY.NORMAL
				elif item == $ScrollContainer/VBoxContainer/ArmourSelection/UncommonArmour:
					quest_rewards_selection_boxes[child] = BaseItem.ARMOUR_QUALITY.UNCOMMON
				elif item == $ScrollContainer/VBoxContainer/ArmourSelection/RareArmour:
					quest_rewards_selection_boxes[child] = BaseItem.ARMOUR_QUALITY.RARE
				elif item == $ScrollContainer/VBoxContainer/ArmourSelection/EpicArmour:
					quest_rewards_selection_boxes[child] = BaseItem.ARMOUR_QUALITY.EPIC
	for item in $ScrollContainer/VBoxContainer/HBoxContainer.get_children():
		for child in item.get_children():
			if child is CheckBox:
				potionCheckBoxes.append(child)
				child.connect("pressed", self, "_potionscheckbox_handler",[child],0)
				child.pressed = false
				if item == $ScrollContainer/VBoxContainer/HBoxContainer/AlchemistNormal:
					quest_rewards_selection_boxes[child] = BaseItem.POTION_QUALITY.NORMAL
				elif item == $ScrollContainer/VBoxContainer/HBoxContainer/AlchemistUncommon:
					quest_rewards_selection_boxes[child] = BaseItem.POTION_QUALITY.UNCOMMON
				elif item == $ScrollContainer/VBoxContainer/HBoxContainer/AlchemistRare:
					quest_rewards_selection_boxes[child] = BaseItem.POTION_QUALITY.RARE
				elif item == $ScrollContainer/VBoxContainer/HBoxContainer/AlchemistEpic:
					quest_rewards_selection_boxes[child] = BaseItem.POTION_QUALITY.EPIC
	


func _weaponcheckbox_handler(checkBox: CheckBox) -> void:
	emit_signal("selected_items_changed", BaseItem.ITEM_TYPE.WEAPON,quest_rewards_selection_boxes[checkBox],checkBox.pressed)
	selected_rewards_weapons[quest_rewards_selection_boxes[checkBox]] = checkBox.pressed
	for item in weaponCheckBoxes:
		var temp : CheckBox = item
		if temp != checkBox:
			temp.pressed = false
			selected_rewards_weapons[quest_rewards_selection_boxes[item]] = false
	#process_selected_rewards()
	set_amount_of_players_to_reward(amount_of_players_to_reward)


func _armourcheckbox_handler(checkBox: CheckBox) -> void:
	emit_signal("selected_items_changed", BaseItem.ITEM_TYPE.ARMOUR,quest_rewards_selection_boxes[checkBox],checkBox.pressed)
	selected_rewards_armour[quest_rewards_selection_boxes[checkBox]] = checkBox.pressed
	for item in armourCheckBoxes:
		var temp : CheckBox = item
		if temp != checkBox:
			temp.pressed = false
			selected_rewards_armour[quest_rewards_selection_boxes[item]] = false
	#process_selected_rewards()
	set_amount_of_players_to_reward(amount_of_players_to_reward)


func _potionscheckbox_handler(checkBox: CheckBox) -> void:
	emit_signal("selected_items_changed", BaseItem.ITEM_TYPE.POTION, quest_rewards_selection_boxes[checkBox],checkBox.pressed)
	selected_rewards_potion[quest_rewards_selection_boxes[checkBox]] = checkBox.pressed
	for item in potionCheckBoxes:
		var temp : CheckBox = item
		if temp != checkBox:
			temp.pressed = false
			selected_rewards_potion[quest_rewards_selection_boxes[item]] = false
	#process_selected_rewards()
	set_amount_of_players_to_reward(amount_of_players_to_reward)


func _on_HSlider_value_changed(value):
	money_slider.value = int(value / 50) * 50
	money_label.text = String(int(money_slider.value))
	set_amount_of_players_to_reward(amount_of_players_to_reward)


func _process(delta):
	if (bInPartyRewardHint or bInPenaltyHint) and not bStopTimer:
		hintTimePassed += delta
		if hintTimePassed >= hintTimer:
			bStopTimer = true
			if bInPartyRewardHint:
				rewardPopUp.popup()
				rewardPopUp.rect_position = Vector2(get_viewport().get_mouse_position().x, get_viewport().get_mouse_position().y - rewardPopUp.rect_size.y)
			elif bInPenaltyHint:
				penaltyPopUp.popup()
				penaltyPopUp.rect_position = Vector2(get_viewport().get_mouse_position().x, get_viewport().get_mouse_position().y - penaltyPopUp.rect_size.y)


func _on_PartyRewardHint_mouse_entered():
	bInPartyRewardHint = true
	bInPenaltyHint = false
	bStopTimer = false
	hintTimePassed = 0


func _on_PartyRewardHint_mouse_exited():
	bInPartyRewardHint = false
	rewardPopUp.hide()


func _on_PenaltyHint_mouse_entered():
	bInPartyRewardHint = false
	bInPenaltyHint = true
	bStopTimer = false
	hintTimePassed = 0


func _on_PenaltyHint_mouse_exited():
	bInPenaltyHint = false
	penaltyPopUp.hide()


func Reset():
	reward_value = 0
	penalty_amount_label.text = "0"
	penalty_amount = 0
	money_slider.value = 0
	for box in quest_rewards_selection_boxes:
		(box as CheckBox).pressed = false
	amount_of_players_to_reward = 0
	amount_of_weapons_label.text = String(0)
	amount_of_armour_label.text = String(0)
	
	for item in selected_rewards_weapons:
		selected_rewards_weapons[item] = false
	for item in selected_rewards_armour:
		selected_rewards_armour[item] = false
	for item in selected_rewards_potion:
		selected_rewards_potion[item] = false
		
	for box in potionCheckBoxes:
		(box as CheckBox).disabled = true
		(box as CheckBox).modulate = Color.gray * .2
	
	for item in BaseItem.POTION_QUALITY:
		if StockData.current_stock_data[BaseItem.POTION_QUALITY[item]] > 0:
			(potion_selectionboxes[BaseItem.POTION_QUALITY[item]] as CheckBox).disabled = false
			(potion_selectionboxes[BaseItem.POTION_QUALITY[item]] as CheckBox).modulate = Color.white
	
	process_selected_rewards()


func set_amount_of_players_to_reward(amount : int) -> void:
	process_selected_rewards()
	amount_of_players_to_reward = amount
	amount_of_weapons_label.text = String(amount)
	amount_of_armour_label.text = String(amount)
	amount_of_gold_label.text = String(int(money_label.text) * amount)
	penalty_amount +=  int(int(money_label.text) * 1.5 * amount)
	reward_value += int(money_label.text)
	penalty_amount_label.text = String(penalty_amount)
	emit_signal("quest_value_changed", reward_value)


func process_selected_rewards() -> void:
	penalty_amount = 0
	reward_value = 0
	
	for item in reward_icon_collection_weapons.values():
		(item as TextureRect).visible = false
	var selected_a_weapon = false
	for item in BaseItem.WEAPON_QUALITY.values():
		if selected_rewards_weapons[item]:
			reward_icon_collection_weapons[item].visible = true
			selected_a_weapon = true
			penalty_amount += BaseItem.item_collection_penalty[item]
			reward_value += BaseItem.item_collection_value[item]
			break
	if !selected_a_weapon:
		amount_of_weapons_label.visible = false
	else:
		amount_of_weapons_label.visible = true
	
	for item in reward_icon_collection_armour.values():
		(item as TextureRect).visible = false
	var selected_a_armour = false
	for item in BaseItem.ARMOUR_QUALITY.values():
		if selected_rewards_armour[item]:
			reward_icon_collection_armour[item].visible = true
			selected_a_armour = true
			penalty_amount += BaseItem.item_collection_penalty[item]
			reward_value += BaseItem.item_collection_value[item]
			break
	if !selected_a_armour:
		amount_of_armour_label.visible = false
	else:
		amount_of_armour_label.visible = true


func get_reward_value() -> int :
	return reward_value