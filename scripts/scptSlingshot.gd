extends Node2D
var can_be_used = false;
var mouse_pos
onready var top_sling = $lTop_sling
onready var down_sling = $sTexture/lDown_sling
onready var bird = preload("res://scenes/entities/scnBird.tscn")

export(float) var speed_modifier
export(float) var max_radius

func _ready():
	top_sling.hide()
	down_sling.hide()

func _input(_event):
	if !can_be_used:
		return
	if Input.is_action_pressed("leftMouse"):
			mouse_pos = get_local_mouse_position()
			show_sling(true)
			# Limit the distance radius
			if mouse_pos.distance_to($pCenter.position) > max_radius:
				mouse_pos = ((mouse_pos - $pCenter.position).normalized() * max_radius + $pCenter.position)
			top_sling.points[0] = mouse_pos
			down_sling.points[0] = mouse_pos
			$asNot_bird.position = mouse_pos
	elif Input.is_action_just_released("leftMouse"):
		show_sling(false)
		throw_not_bird($asNot_bird.global_position)
		$asNot_bird.position = Vector2(0, 0)
		can_be_used = false

func show_sling(show):
	if show:
		top_sling.show()
		down_sling.show()
	else:
		top_sling.hide()
		down_sling.hide()

func _on_aSlingshot_Hitbox_input_event(_viewport, _event, _shape_idx):#this strigger when the mouse is over the chHitbox
	can_be_used = true

func throw_not_bird(last_mouse_pos):
	var real_bird = bird.instance()
	get_parent().add_child(real_bird)
	real_bird.position = last_mouse_pos
	var speed = $pCenter.global_position - last_mouse_pos
	real_bird.apply_central_impulse(speed * speed_modifier)
	$asNot_bird.hide()
