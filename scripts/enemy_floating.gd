extends Enemy

export(float) var force = 10.0
export(float) var death_countdown = 2.5

onready var initial_height = position.y

func _physics_process(delta):
	._physics_process(delta)
	if position.y > initial_height:
		var height_difference = position.y - initial_height
		var impulse: Vector2 = Vector2.UP * force * height_difference * delta
		apply_central_impulse(impulse.rotated(rotation))
	
func _process(delta):
	#._process(delta)
	if health < initial_health * 0.7:
		death_countdown -= delta
	if death_countdown <= 0:
		die()
