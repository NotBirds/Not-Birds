extends Area2D

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body is RigidBody2D && body.get_collision_layer_bit(1):
			var impulse = to_local(body.global_position).normalized()
			body.linear_velocity += (to_global(impulse) - global_position) * 40.0
			$projectile.points[1] = to_local(body.global_position) #+ to_local(self.global_position)
