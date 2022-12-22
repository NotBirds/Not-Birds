extends Camera2D
var can_be_used = true
const DEAD_ZONE = 80
var camera_speed
	
func _input(event: InputEvent) -> void:
	if !can_be_used:
		camera_speed = 0.013
	if event is InputEventMouseMotion:
		camera_speed =+ 0.02
		var _target = event.position - get_viewport().size * camera_speed
		if _target.length() < DEAD_ZONE:
			self.position = Vector2(0,0)
		else:
			self.position = _target.normalized() * (_target.length() - DEAD_ZONE) * camera_speed

func _on_aLoock_mouse_entered():
	can_be_used = false

func _on_aLoock_mouse_exited():
	can_be_used = true
