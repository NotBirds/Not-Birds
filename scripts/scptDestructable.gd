extends RigidBody2D

export(float) var health = 1.0 #0.001 andaba
export(float) var death_treshold = 0.001
export(float) var base_collision_pitch = 1.0
export(float) var base_destroy_pitch = 1.0

func _on_plank_body_entered(body):
	if body is RigidBody2D:
		var impact_velocity = (body.linear_velocity - self.linear_velocity).length()
		if impact_velocity > 1:
			if !$audioCollision.playing:
				$audioCollision.pitch_scale = base_collision_pitch + randf()
				$audioCollision.play()
			if impact_velocity > 80:
				damage(impact_velocity * body.mass * death_treshold)

func _ready():
	$audioCollision.pitch_scale = base_collision_pitch
	$audioDestroy.pitch_scale = base_destroy_pitch

func damage(value):
	health -= value
	$Sprite.modulate.g = health
	$Sprite.modulate.b = health
	if health <= 0:
		die()

func die():
	if !$audioDestroy.playing:
		$audioDestroy.pitch_scale = base_destroy_pitch + randf()
		$audioDestroy.play()
	$Sprite.visible = false;
	$physicsCollider.set_deferred("disabled", true);
	yield($audioDestroy, "finished")
	queue_free()
