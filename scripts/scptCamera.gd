extends Camera2D
var can_be_used = true
const DEAD_ZONE = 80
var camera_speed
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			can_be_used = !event.pressed
			
	if event is InputEventMouseMotion || event is InputEventMouseButton:
		var _target = event.global_position - get_viewport().size * 0.1
		if _target.length() < DEAD_ZONE:
			self.position = Vector2(0,0)
		else:
			var move_to = _target.normalized() * (_target.length() - DEAD_ZONE) * 0.1
			self.position = self.position + (move_to - self.position) * 0.5
			
