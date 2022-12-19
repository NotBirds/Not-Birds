extends Node2D
var can_be_used = false;
var mouse_pos
onready var top_sling = $lTop_sling
onready var down_sling = $sTexture/lDown_sling
onready var sling_center = $pCenter
onready var not_bird = $asNot_bird
onready var bird = preload("res://entities/scnBird.tscn")

func _ready():
	top_sling.hide()
	down_sling.hide()
	sling_center = sling_center.position #if the sling is going to move, remember to update this poss
	

func _process(_delta):
	if !can_be_used:
		return

func _input(_event):
	if !can_be_used:
		return
	if Input.is_action_pressed("leftMouse"):
			mouse_pos = get_local_mouse_position()
			top_sling.show()
			down_sling.show()
			if mouse_pos.distance_to(sling_center) > 1000:
				mouse_pos = ((mouse_pos - sling_center).normalized() * 1000  + sling_center)
			top_sling.points[0] = mouse_pos
			down_sling.points[0] = mouse_pos
			not_bird.position += (mouse_pos - not_bird.position) * Vector2(0.5,0.5)
	elif Input.is_action_just_released("leftMouse"):
		top_sling.hide()
		down_sling.hide()
		throw_not_bird(not_bird.global_position)
		not_bird.position = Vector2(-580 , 271) #+= (Vector2(-580 , 271) - not_bird.position) * Vector2(0.5,0.5) #makes it go smoot 
		can_be_used = false

func _on_aSlingshot_Hitbox_input_event(_viewport, _event, _shape_idx):#this strigger when the mouse is over the chHitbox
	can_be_used = true

func throw_not_bird(last_mouse_pos):
	var real_bird = bird.instance()
	get_parent().add_child(real_bird)
	real_bird.position = last_mouse_pos
	var speed = $pCenter.global_position - last_mouse_pos
	real_bird.apply_impulse(Vector2(), speed * 2)
	not_bird.hide()
