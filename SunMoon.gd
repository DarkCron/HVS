extends Node2D

var started_cycle = false;

onready var Parent = self;
onready var Moon = Parent.get_node("Moon")
onready var Sun = Parent.get_node("sun_shiny")

export var total_cycle_time = 3;
var elapsed_time = 0;

func SunMoonCycle():
	if Parent == null or Moon == null or Sun == null:
		pass
	
	if not started_cycle:
		elapsed_time = 0;
	
	started_cycle = true;
	
	pass

func EndCycle():
	started_cycle = false;
	rotation_degrees = 0;
	pass
	
func _process(delta):
	if started_cycle:
		elapsed_time += delta;
		var delta_rot = 360 * elapsed_time / total_cycle_time;
		rotation_degrees = delta_rot;
		
		if elapsed_time >= total_cycle_time:
			EndCycle()
	pass