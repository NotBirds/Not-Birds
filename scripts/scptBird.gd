extends RigidBody2D

export(float) var death_velocity = 0.0

# length_squared() is more efficient than length(),
# so we square death_velocity too
func _ready():
	death_velocity *= death_velocity

func _process(delta):
	if linear_velocity.length_squared() <= death_velocity:
		$audioDeath.play()
		$sprite.visible = false;
		$csHitbox.set_deferred("disabled", true)
		yield($audioDeath, "finished")
		queue_free()
