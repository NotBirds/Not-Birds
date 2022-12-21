extends RigidBody2D

export(float) var health = 0.001 #0.001 andaba
export(float) var death_treshold = 0.001
var death = false
# export(float) var base_collision_pitch = 1
# export(float) var base_destroy_pitch = 1

func _on_Enemy_body_entered(body):
	print("entered")
	if body is RigidBody2D:
		var impact_velocity = (body.linear_velocity - self.linear_velocity).length()
		if impact_velocity > 1:
			if impact_velocity > 80:
				# damage(impact_velocity * body.mass * death_treshold)
				die()

func _ready():
	# $audioCollision.pitch_scale = base_collision_pitch
	# $audioDestroy.pitch_scale = base_destroy_pitch
	pass

func _process(delta):
	if death:
		queue_free()

func damage(value):
	health -= value
	$Sprite.modulate.g = health
	$Sprite.modulate.b = health
	if health <= 0:
		# if !$audioDestroy.playing:
		# 	$audioDestroy.pitch_scale = base_destroy_pitch + randf()
		# 	$audioDestroy.play()
		die()

func die():
	print("Death")
	death = true
	$Sprite.visible = false;
	$CollisionShape2D.disabled = true;
	print("Died")
