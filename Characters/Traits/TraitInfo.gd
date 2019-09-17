extends Control

onready var traitNameLabel : Label = $HBoxContainer/TraitNameLabel
onready var traitDescription: RichTextLabel = $RichTextLabel

var trait : BaseTrait


func Initialize(trait: BaseTrait) -> void:
	self.trait = trait
	traitNameLabel.text = trait.name
	traitDescription.text = trait.description