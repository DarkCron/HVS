extends PopupDialog

class_name ErrorPupup

export var base_color : Color
export var fade_timer : float = 1.0
var start_fade_time : float = 2.0
var time_passed : float = 0.0

func Initialize() -> void:
	time_passed = 0.0
	modulate = base_color


func _process(delta):
	if !visible:
		return
	
	time_passed += delta
	
	if time_passed >= start_fade_time:
		modulate = modulate * (((fade_timer-start_fade_time)-(time_passed-start_fade_time))/(fade_timer-start_fade_time))
	
	if time_passed >= fade_timer:
		hide()