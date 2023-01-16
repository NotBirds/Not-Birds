extends Enemy

export(float) var force = 40.0
onready var repel_zone = $repel_zone
onready var projectile = $repel_zone/projectile

func _physics_process(delta):
	._physics_process(delta)
	for body in repel_zone.get_overlapping_bodies():
		if body is RigidBody2D && body.get_collision_layer_bit(1):
			var impulse = to_local(body.global_position).normalized()
			body.linear_velocity += (to_global(impulse) - repel_zone.global_position) * force
			projectile.points[1] = to_local(body.global_position)
