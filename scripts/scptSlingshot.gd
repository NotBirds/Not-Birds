extends Node2D
var can_be_used = false;
var mouse_pos
onready var target_pos = position
onready var top_sling = $lTop_sling
onready var down_sling = $lDown_sling
onready var aim_sound = $aimSound
onready var shot_sound = $shotSound
onready var bird = preload("res://scenes/entities/scnBird.tscn")

export(float) var speed_modifier
export(float) var max_radius

func _input(_event):
	if can_be_used:
		if Input.is_action_pressed("leftMouse"):
			if !aim_sound.playing:
				aim_sound.play()
			mouse_pos = get_local_mouse_position()
			set_sling_visible(true)
			# Limit the distance radius
			if mouse_pos.distance_to($pCenter.position) > max_radius:
				mouse_pos = ((mouse_pos - $pCenter.position).normalized() * max_radius + $pCenter.position)
			top_sling.points[0] = mouse_pos
			down_sling.points[0] = mouse_pos
			$asNot_bird.position = mouse_pos
		elif Input.is_action_just_released("leftMouse"):
			aim_sound.stop()
			throw_not_bird($asNot_bird.global_position)

func _process(_delta):
	position = lerp(position, target_pos, 0.2)

func set_sling_visible(show):
	top_sling.visible = show;
	down_sling.visible = show;
	
# This triggers when the mouse is over the hitbox
func _on_aSlingshot_Hitbox_input_event(_viewport, _event, _shape_idx):
	can_be_used = true

func throw_not_bird(last_mouse_pos):
	shot_sound.play()
	set_sling_visible(false)
	$asNot_bird.position = Vector2(0, 0)
	can_be_used = false
	var real_bird = bird.instance()
	get_parent().add_child(real_bird)
	real_bird.position = last_mouse_pos
	var speed = $pCenter.global_position - last_mouse_pos
	real_bird.apply_central_impulse(speed * speed_modifier)
	$asNot_bird.hide()

func _on_move_slingshot(new_pos: Vector2):
	target_pos = new_pos
