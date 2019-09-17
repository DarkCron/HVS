extends Sprite

onready var originPos = self.position;

export var delta_y = 25
export var up_down_speed = 1
var elapsed_time = 0
var do_move = true;
var moving_up = true;

func _process(delta):
	elapsed_time += delta
	var delta_distance = delta_y * elapsed_time/ up_down_speed;
	
	if moving_up:
		self.position = Vector2(self.position.x,originPos.y + delta_distance)
	else:
		self.position = Vector2(self.position.x,originPos.y + delta_y - delta_distance)
	
	if elapsed_time >= up_down_speed:
		elapsed_time = 0
		moving_up = not moving_up
	pass
	
func Start():
	do_move = true
	pass
	
func Stop():
	do_move = false
	Reset()
	pass
	
func Reset():
	self.position = originPos
	elapsed_time = 0;
	pass


