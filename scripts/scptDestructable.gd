extends RigidBody2D

export(float) var health = 1 #0.001 andaba
export(float) var death_treshold = 0.00085

func _on_plank_body_entered(body):
	if body is RigidBody2D:
		if body.collision_layer == 1: # Checks if it's a bird
			print("Me tocó un pajaro owoo")
		if body.collision_layer == 2: # Checks if it's a plank
			print("Me tocó una tabla")
		var impact_velocity = (body.linear_velocity - self.linear_velocity).length()
		if impact_velocity > 80:
			damage(impact_velocity * body.mass * death_treshold)
		print(health, " ", impact_velocity)
	print("AAAAAAAa", death_treshold)
		
func damage(value):
	health -= value
	if health <= 0:
		queue_free()
