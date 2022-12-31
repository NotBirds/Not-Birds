extends RigidBody2D

export(float) var death_velocity = 0.0
export(float) var max_aim_distance = 200.0
export(float) var speed_modifier = 10.0

var shooting = false
var shoot_pos: Vector2
var is_grounded = false;

onready var aim_pointer: Sprite = $aim_pointer
onready var hitbox: Area2D = $aim_area
onready var max_cursor_scale = aim_pointer.scale

# length_squared() is more efficient than length(),
# so we square death_velocity too
func _ready():
	death_velocity *= death_velocity

# Prevent the character from rotating
func _integrate_forces(state):
	rotation = 0
	angular_velocity = 0.0

func set_shooting(var value: bool):
	shooting = value
	aim_pointer.visible = value
	if value:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && !event.pressed && is_grounded:
			throw_not_bird()
			set_shooting(false)
	elif event is InputEventMouseMotion && shooting:
		shoot_pos = get_local_mouse_position()
		shoot_pos = shoot_pos.normalized() * clamp(shoot_pos.length(), 0, max_aim_distance)
		var pointer_scale = shoot_pos.length() / max_aim_distance
		aim_pointer.scale = max_cursor_scale * log((1+pointer_scale)*3.0)
		aim_pointer.position = shoot_pos

func throw_not_bird():
	var speed = -shoot_pos
	apply_central_impulse(speed * speed_modifier)

func _on_aim_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event is InputEventMouseButton:
		var is_still = linear_velocity.length_squared() < 1
		if event.button_index == BUTTON_LEFT && event.pressed && is_still:
			set_shooting(true)


func _on_grounded_area_body_entered(_body):
	is_grounded = true

func _on_grounded_area_body_exited(_body):
	is_grounded = false
