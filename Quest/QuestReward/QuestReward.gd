extends Control

onready var rewardPopUp : PopupDialog = $PartyRewardHintPopup
onready var penaltyPopUp : PopupDialog = $PenaltyHintPopup

onready var money_label : Label = $MoneyRewardAmount
onready var money_slider : HSlider = $HSlider

var weaponCheckBoxes : Array = []
var armourCheckBoxes : Array = []
var potionCheckBoxes : Array = []

var quest_rewards_selection : Dictionary = {}

var bInPartyRewardHint := false
var bInPenaltyHint := false
var bStopTimer := false

var hintTimer := 1
var hintTimePassed := 0.0

signal quest_value_changed
signal selected_items_changed


func _ready():
	for item in $ScrollContainer/VBoxContainer/WeaponSelection.get_children():
		for child in item.get_children():
			if child is CheckBox:
				weaponCheckBoxes.append(child)
				child.connect("pressed", self, "_weaponcheckbox_handler",[child],0)
				child.pressed = false
				if item == $ScrollContainer/VBoxContainer/WeaponSelection/NormalWeapon:
					quest_rewards_selection[child] = "NormalWeapon"
				elif item == $ScrollContainer/VBoxContainer/WeaponSelection/UncommonWeapon:
					quest_rewards_selection[child] = "UncommonWeapon"
				elif item == $ScrollContainer/VBoxContainer/WeaponSelection/RareWeapon:
					quest_rewards_selection[child] = "RareWeapon"
				elif item == $ScrollContainer/VBoxContainer/WeaponSelection/EpicWeapon:
					quest_rewards_selection[child] = "EpicWeapon"
	for item in $ScrollContainer/VBoxContainer/ArmourSelection.get_children():
		for child in item.get_children():
			if child is CheckBox:
				armourCheckBoxes.append(child)
				child.connect("pressed", self, "_armourcheckbox_handler",[child],0)
				child.pressed = false
				if item == $ScrollContainer/VBoxContainer/ArmourSelection/NormalArmour:
					quest_rewards_selection[child] = "NormalArmour"
				elif item == $ScrollContainer/VBoxContainer/ArmourSelection/UncommonArmour:
					quest_rewards_selection[child] = "UncommonArmour"
				elif item == $ScrollContainer/VBoxContainer/ArmourSelection/RareArmour:
					quest_rewards_selection[child] = "RareArmour"
				elif item == $ScrollContainer/VBoxContainer/ArmourSelection/EpicArmour:
					quest_rewards_selection[child] = "EpicArmour"
	for item in $ScrollContainer/VBoxContainer/HBoxContainer.get_children():
		for child in item.get_children():
			if child is CheckBox:
				potionCheckBoxes.append(child)
				child.connect("pressed", self, "_potionscheckbox_handler",[child],0)
				child.pressed = false
				if item == $ScrollContainer/VBoxContainer/HBoxContainer/AlchemistNormal:
					quest_rewards_selection[child] = "NormalPotion"
				elif item == $ScrollContainer/VBoxContainer/HBoxContainer/AlchemistUncommon:
					quest_rewards_selection[child] = "UncommonPotion"
				elif item == $ScrollContainer/VBoxContainer/HBoxContainer/AlchemistRare:
					quest_rewards_selection[child] = "RarePotion"
				elif item == $ScrollContainer/VBoxContainer/HBoxContainer/AlchemistEpic:
					quest_rewards_selection[child] = "EpicPotion"


func _weaponcheckbox_handler(checkBox: CheckBox) -> void:
	emit_signal("selected_items_changed")
	for item in weaponCheckBoxes:
		var temp : CheckBox = item
		if temp != checkBox:
			temp.pressed = false


func _armourcheckbox_handler(checkBox: CheckBox) -> void:
	emit_signal("selected_items_changed")
	for item in armourCheckBoxes:
		var temp : CheckBox = item
		if temp != checkBox:
			temp.pressed = false


func _potionscheckbox_handler(checkBox: CheckBox) -> void:
	emit_signal("selected_items_changed")
	for item in potionCheckBoxes:
		var temp : CheckBox = item
		if temp != checkBox:
			temp.pressed = false


func _on_HSlider_value_changed(value):
	money_slider.value = int(value / 50) * 50
	money_label.text = String(int(money_slider.value))


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


