extends Area2D

func _ready():
	pass

func _on_range_body_entered(body):
	# self.rotation = $enemy.rotation
	print(body.global_position)
	print(self.global_position)
	$projectile.points[1] = to_local(body.global_position) + to_local(self.global_position)
	
	body.linear_velocity = -body.linear_velocity * 5
