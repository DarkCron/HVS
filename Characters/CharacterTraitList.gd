extends PopupDialog

onready var trait_container : VBoxContainer  = $ScrollContainer/VBoxContainer
onready var scroll_container : ScrollContainer = $ScrollContainer

var trait_node = preload("res://Characters/Traits/TraitInfo.tscn")

export var popup_position : Vector2 
var test : SpecificTrait = SpecificTrait.new()

var traits : Array


func _ready() -> void:
	test.do_something_else()
	#self.popup()
	
	var trait_array := []
	
	var tempTrait = BaseTrait.new()
	tempTrait.Initialize("Test 1","Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ultricies dolor at diam accumsan tincidunt. Vivamus id tempor est. Donec ut convallis nisl, facilisis vehicula augue. Ut sed condimentum magna. Nulla nec elit hendrerit, laoreet erat id, sollicitudin metus. Sed vestibulum massa a justo scelerisque pretium. Morbi faucibus, leo imperdiet commodo placerat, lacus risus accumsan dui, vitae iaculis risus libero non sem. ")
	trait_array.insert(trait_array.size(),tempTrait)
	
	tempTrait = BaseTrait.new()
	tempTrait.Initialize("Test 2","Phasellus in libero vitae dolor dapibus vehicula et vitae leo. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec aliquet venenatis purus, in luctus arcu aliquet id. Fusce scelerisque at tortor a accumsan. Quisque condimentum ex ut maximus lobortis. Proin magna purus, efficitur molestie tellus sit amet, suscipit aliquam dui. In at augue sed augue sollicitudin faucibus a eget nisl. Curabitur ut massa facilisis, porta turpis ac, tincidunt massa. Mauris mauris nisi, accumsan at dolor elementum, laoreet congue nisl. In eget lacus porta risus aliquet volutpat vitae in magna. Praesent luctus ipsum risus, ac vestibulum nulla maximus nec. Pellentesque interdum nunc felis, id imperdiet nisl vulputate quis. Etiam eget efficitur felis. Ut vel mattis metus, euismod malesuada tortor. Nam et sagittis elit. Phasellus vel dictum felis. ")
	trait_array.insert(trait_array.size(),tempTrait)
	
	tempTrait = BaseTrait.new()
	tempTrait.Initialize("Test 3","Phasellus in libero vitae dolor dapibus vehicula et vitae leo. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec aliquet venenatis purus, in luctus arcu aliquet id. Fusce scelerisque at tortor a accumsan. Quisque condimentum ex ut maximus lobortis. Proin magna purus, efficitur molestie tellus sit amet, suscipit aliquam dui. In at augue sed augue sollicitudin faucibus a eget nisl. Curabitur ut massa facilisis, porta turpis ac, tincidunt massa. Mauris mauris nisi, accumsan at dolor elementum, laoreet congue nisl. In eget lacus porta risus aliquet volutpat vitae in magna. Praesent luctus ipsum risus, ac vestibulum nulla maximus nec. Pellentesque interdum nunc felis, id imperdiet nisl vulputate quis. Etiam eget efficitur felis. Ut vel mattis metus, euismod malesuada tortor. Nam et sagittis elit. Phasellus vel dictum felis. ")
	trait_array.insert(trait_array.size(),tempTrait)
	
	tempTrait = BaseTrait.new()
	tempTrait.Initialize("Test 4","Phasellus in libero vitae dolor dapibus vehicula et vitae leo. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec aliquet venenatis purus, in luctus arcu aliquet id. Fusce scelerisque at tortor a accumsan. Quisque condimentum ex ut maximus lobortis. Proin magna purus, efficitur molestie tellus sit amet, suscipit aliquam dui. In at augue sed augue sollicitudin faucibus a eget nisl. Curabitur ut massa facilisis, porta turpis ac, tincidunt massa. Mauris mauris nisi, accumsan at dolor elementum, laoreet congue nisl. In eget lacus porta risus aliquet volutpat vitae in magna. Praesent luctus ipsum risus, ac vestibulum nulla maximus nec. Pellentesque interdum nunc felis, id imperdiet nisl vulputate quis. Etiam eget efficitur felis. Ut vel mattis metus, euismod malesuada tortor. Nam et sagittis elit. Phasellus vel dictum felis. ")
	trait_array.insert(trait_array.size(),tempTrait)
	
	Initialize(trait_array)


func Initialize(input: Array) -> void:
	self.traits = input
	
	for child in trait_container.get_children():
		child.queue_free()
		
	for item in input:
		var tempChild = trait_node.instance()
		trait_container.add_child(tempChild)
		tempChild.Initialize(item)


func _on_CharacterTraitList_about_to_show():
	self.rect_position = popup_position
	self.rect_position = get_viewport().get_mouse_position() + Vector2(-self.rect_size.x,0)
	scroll_container.scroll_vertical = 0
	pass # Replace with function body.


